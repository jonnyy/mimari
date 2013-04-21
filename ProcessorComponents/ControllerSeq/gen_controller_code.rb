# Converst CSV file to verilog code for output of state machine
require 'csv'

csv = CSV.read(ARGV.first)
DEFAULT_STATES_LIST = "states_list.txt"
DEFAULT_VERILOG_OUTPUT = "state_outputs.v"
DEFAULT_PARAMETER_OUTPUT = "paramter_encoding.v"

# Remove first row of submodule names for each signal
csv.shift

# Remove "State Name" title
csv.first.shift

# Delete any extraneous characters in the signal name
sig_names = csv.first.compact.each { |sig| sig.gsub!(/\[.*\]|[^\w]/, "") }

# Remove header line of CSV file
csv.shift

# List of state names
states = Array.new

# Open file to write verilog code to
f = File.open(DEFAULT_VERILOG_OUTPUT, "w")

# Put time output was generated
f.puts "// Generated on #{Time.now}"

# Print out verilog code
csv.each do |line|
  states << line.first # Capture state name
  f.puts "#{line.shift}: begin"
  line.shift
  sig_names.zip(line).each do |name, value|
    if /^\d+$/.match(value)
      f.puts "    #{name} = #{value.length}'b#{value};"
    else
      f.puts "    #{name} = #{value};"
    end
  end
  f.puts "end"
end
f.close

# Write state names to file
File.open(DEFAULT_STATES_LIST, "w") { |f| f.puts(states) }

# Open parameter encoding file for writing
param = File.open(DEFAULT_PARAMETER_OUTPUT, "w")

# Remove 'default' state from list of states so we don't include it in the 
# list of states
puts states.pop

param.puts "parameter"
states.each_with_index do |s, i|
  binary = "0" * states.length
  binary[i] = "1"
  hex = "%0#{(states.length/4.0).ceil}x" % binary.to_i(2)
  hex = "#{states.length}'h" + hex
  param.print "    #{s} = #{hex}" 
  if i == (states.length - 1)
    param.puts ";"
  else
    param.puts ","
  end
end
param.close
