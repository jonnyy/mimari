# Outputs parameters of each state to STDOUT

states = Array.new
DEFAULT_PARAM_FILE = "parameter_encodings.v"

# Read in states
File.readlines(ARGV.first).each { |state| states << state.chomp }

# Open file for writing
f = File.open(DEFAULT_PARAM_FILE, "w")

f.puts "parameter"
states.each_with_index do |s, i|
  binary = "0" * states.length
  binary[i] = "1"
  binary = "#{states.length}'b" + binary
  f.print "    #{s} = #{binary}" 
  if i == (states.length - 1)
    f.puts ";"
  else
    f.puts ","
  end
end
