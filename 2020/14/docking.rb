#!/usr/bin/ruby
input = $stdin.read

puts "input #{input}"  
instructions = input.split(/\n/)
puts "instructrions: #{instructions}"

memory = []
mask = ''

def parseInsruction(instruction) 
	instruction.split(" = ");
end

def decodeValue(value)
	value.to_i.to_s(2)
end

def decodePosition(command)
	match, pos = /\[\d+\]/.match(command).to_a
	puts "position: #{pos}"
	return pos
end

def applyMask(value, mask)
	bitString = decodeValue(value)
	puts "bitString #{bitString}"
end


instructions.each do |inst| 
	puts "instruction #{inst}"
	command, value = parseInsruction(inst)
	puts "command #{command} value #{value}"
	if (command == 'mask')
		puts "new mask #{mask}"  
		mask = value
	else
		maskedValue = applyMask(value, mask)
		puts "before: #{value} after: #{maskedValue}"
		memory[decodePosition(command)] = maskedValue
	end
end

sum = memory.reduce { |sum, value| sum + value }

puts "sum #{sum}"



