#!/usr/bin/env ruby
require 'optparse'

class Instruction
    def initialize(*inst)
        if inst.first =~ /[a-zA-Z][a-zA-Z0-9]+:/
            @label = inst.shift
        else
            @label = nil
        end
        @opcode = inst.shift.downcase.to_sym
        case inst.first
            when /\$/ then @addr_mode = :indirect
            when /#/ then @addr_mode = :immediate
            when nil then @addr_mode = :other
            else @addr_mode = :direct
        end
        if @addr_mode == :direct
            @value = inst.first
        elsif @addr_mode == :other
            @value = nil
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
        if OPCODE_MAP.has_key? @opcode
            bin << OPCODE_MAP[@opcode]
        else
            STDERR.puts "ERROR: invalid opcode '#{@opcode}'"
            exit
        end
        bin << case @addr_mode
            when :immediate then "00"
            when :direct then "10"
            when :indirect then "11"
            else "01"
            end
        bin << case @value
        when /^0x(\h+)$/
	        $1.hex.to_s(2).rjust(8, '0')
        when /^0b([01]+)$/
            "%08b" % $1.to_i(2)
        when /^([a-zA-Z][a-zA-Z0-9]+)$/
            if !@@labels.has_key? $1
                STDERR.puts "ERROR: cannot find label #{$1}"
                exit
            end
            "%08b" % @@labels[$1]
        else
            ("%08b" % @value.to_i).tr('^01', '')
        end
    end

    def to_verilog
        bin = to_binary
        ret = "regArray[#{@@inst_addr}] = #{bin.length}'b#{bin};"
        @@inst_addr += 1
        return ret
    end

    def to_assembly
        addr_mode_char = case @addr_mode
                         when :indirect then '$'
                         when :immediate then '#'
                         else ''
                         end
        if @label == nil
            "#{@opcode} #{addr_mode_char}#{@value}"
        else
            "#{@label} #{@opcode} #{addr_mode_char}#{@value}"
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
    :output_file   => STDOUT,
    :input_file    => STDIN
}

# Options for script
OptionParser.new do |opts|
    opts.banner = "Usage: assembler.rb file [options]"
    opts.on("-i", "--input-file [file]", String, "take input from [file]",
            "default STDIN") do |f|
        options[:input_file] = f
    end
    opts.on("-n", "--starting-addr N", Integer,
            "Start instructions at address N") do |a|
        unless a > 255
            options[:starting_addr] = a
        else
            STDERR.puts "ERROR: must start addresses at less than 256"
            exit
        end
    end
    opts.on("-o", "--output-file [file]", String,
            "write output to [file]", "default STDOUT") do |f|
        options[:output_file] = f
    end
    opts.on("-t", "--output-type [type]", OUTPUT_TYPES,
            "Set output type to one of the following:",
            "    *verilog",
            "    *binary",
            "    *prettyprint",
            "    *assembly", "'prettyprint' displays both binary and the",
            "associated assembly code",
            "Default is [verilog]") do |t|
        options[:output_type] = t.to_sym
    end
end.parse!

# First pass - read all labels on left column
inst_count = options[:starting_addr]
labels = {}
instructions = []

# Conditionally choose input source
infile = 0
if options[:input_file] == STDIN
    infile = STDIN
else
    infile = File.readlines(options[:input_file])
end

# Read each line
infile.each do |line|
    line.gsub!('%.*$', '')
    if inst_count > 255
        STDERR.puts "ERROR: instructions list extends beyond address 255"
        exit
    end
    line = line.split
    if line.first =~ /[a-zA-Z][a-zA-Z0-9]+:/
        labels[line.first.downcase.chop] = inst_count
    end
    instructions << line
    inst_count += 1
end

# Initialize instructions objects so they know what address to start at and
# what labels exist in the code
Instruction.init(options[:starting_addr], labels)

# Second pass - convert to desired output format
instructions.each do |inst|
    i = Instruction.new(*inst)
    case options[:output_type]
    when :verilog
        options[:output_file].puts i.to_verilog
    when :binary
        options[:output_file].puts i.to_binary
    when :prettyprint
        options[:output_file].puts sprintf("%-20s\t%-20s\t%-s", i.to_assembly,
                                                     i.to_binary, i.to_verilog)
    when :assembly
        options[:output_file].puts i.to_assembly
    end
end
