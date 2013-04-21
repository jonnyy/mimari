#!/usr/bin/env ruby

opcode_map = {
	"add"   => '0000',
	"sub"   => '0001',
	"or"    => '0010',
	"and"   => '0011',
	"srl"   => '0100',
	"sll"   => '0101',
	"cmpl"  => '0110',
	"brz"   => '0111',
	"jmp"   => '1000',
	"ret"   => '1001',
	"ld"    => '1010',
	"sto"   => '1011',
	"in"    => '1100',
	"out"   => '1101',
	"lmask" => '1110',
	"jsr"   => '1111'
}

File.readlines(ARGV.first).each do |line|
	opcode, addr = line.split

    # Determine memory addressing mode
	addr_mode = case addr
	    when /#/ then '00'
	    when /\$/ then '11'
	    when /cmpl|ret|in|out|jsr/ then '01'
	    else then '10'
	    end
	addr.delete!("#", "$")

    # Convert hex (0x...) or bin (0b...) or decimal (\d+) to binary string value
    puts "addr = #{addr}"
	fmt_addr =  case addr
	    when /0x([0-9a-fA-F]+)/
	    	"%08b" % $1.to_i(16)
	    when /0b(0|1)+/
	    	"%08b" % $1.to_i(2)
	    else
	    	"%08b" % addr.to_i
	    end
	instruction = '00' + opcode_map[opcode.downcase] + addr_mode + fmt_addr 
	puts instruction
end
