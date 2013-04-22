#!/usr/bin/env ruby
require 'optparse'

class Instruction
    def initialize(*inst)
        if inst.length == 3
            @label = inst.shift
        else
            @label = nil
        end
        @opcode = inst.shift.downcase.to_sym
        case inst.first
            when /\$/ then @addr_mode = :indirect
            when /#/ then @addr_mode = :immediate
            else @addr_mode = :direct
        end
        if @addr_mode == :direct
            @value = inst.first
        else
            @value = inst.first[1..-1]
        end
    end

    def self.init(n, labels)
        @@inst_addr = n
        @@labels = labels
    end

    def to_binary
        bin = "00"
        bin << OPCODE_MAP[@opcode]
        bin << case @addr_mode
            when :immediate then "00"
            when :direct then "10"
            when :indirect then "11"
            else "01"
            end
        bin << case @value
        when /^0x(\h+)$/
	        $1.hex.to_s(2).rjust(8, '0')
        when /^0b(0|1)/
            "%08b" % $1.to_i(2)
        when /^([a-zA-Z][a-zA-Z0-9]+)$/
            "%08b" % @@labels[$1]
        else
            "%08b" % @value.to_i
        end
    end

    def to_verilog
        bin = to_binary
        ret = "regArray[#{@@inst_addr}] = #{bin.length}'b#{bin}"
        @@inst_addr += 1
        return ret
    end

    def to_assembly
        if @label == nil
            "#{@opcode} #{@value}"
        else
            "#{@label} #{@opcode} #{@value}"
        end
    end

    # Maps opcode names to binary values
    OPCODE_MAP = {
	    :add   => '0000',
	    :sub   => '0001',
	    :or    => '0010',
	    :and   => '0011',
	    :srl   => '0100',
	    :sll   => '0101',
	    :cmpl  => '0110',
	    :brz   => '0111',
	    :jmp   => '1000',
	    :ret   => '1001',
	    :ld    => '1010',
	    :st    => '1011',
	    :in    => '1100',
	    :out   => '1101',
	    :lmask => '1110',
	    :jsr   => '1111'
    }
end

OUTPUT_TYPES = [:verilog, :binary, :prettyprint, :assembly]

# Default options
options = {
    :starting_addr => 0,
    :output_type   => :verilog,
    :output_file   => nil,
    :input_file    => nil
}

OptionParser.new do |opts|
    opts.banner = "Usage: assembler.rb file [options]"
    opts.on("-s", "--starting-addr N", Integer, "Start instructions at address N") do |a|
        options[:starting_addr] = a
    end
    opts.on("-t", "--output-type [type]", OUTPUT_TYPES,
            "Set output type to one of the following:", "    *verilog", "    *binary",
            "    *prettyprint", "    *assembly", "'prettyprint' displays both binary and the",
            "associated assembly code") do |t|
        options[:output_type] = t.to_sym
    end
    opts.on("-o", "--output-file [file]", String, "write output to [file]") do |f|
        options[:output_file] = f
    end
    opts.on("-i", "--input-file [file]", String, "take input from [file]") do |f|
        options[:input_file] = f
    end
end.parse!

infile = String.new
if options.has_key? :input_file
    infile = options[:input_file]
else
    infile = STDIN
end

# First pass - read all labels on left column
inst_count = options[:starting_addr]
labels = Hash.new
instructions = Array.new
File.readlines(infile).each do |line|
    line = line.split
    if line.length == 3
        labels[line.first.downcase.chop] = inst_count
    end
    instructions << line
    inst_count += 1
end

Instruction.init(options[:starting_addr], labels)

# Second pass - convert to instructions
instructions.each do |inst|
    i = Instruction.new(*inst)
    case options[:output_type]
    when :verilog
        puts i.to_verilog
    when :binary
        puts i.to_binary
    when :prettyprint
        puts sprintf("%-20s\t%-s", i.to_assembly, i.to_verilog)
    end
end
