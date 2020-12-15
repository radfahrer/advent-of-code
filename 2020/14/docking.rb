#!/usr/bin/ruby
input = $stdin.read

instructions = input.split(/\n/)

memory = []
mask = ''

def parseInsruction(instruction) 
	instruction.split(" = ");
end

def decodeValue(value)
	binary_value = "%b" % value
	decoded_value = "%036d" % binary_value
	# puts "value: #{binary_value} decoded_value: #{decoded_value}"
	decoded_value
end

def decodePosition(command)
	match, pos = /\[(\d+)\]/.match(command).to_a
	return pos.to_i
end

def maskBit(bit, maskBit)
	if(maskBit == "X")
		bit
	else
		maskBit
	end
end

def applyMask(value, mask)
	bit_string = decodeValue(value)
	new_bits = bit_string.chars.each_with_index.map do |bit, index| 
		maskBit(bit, mask.chars[index])
	end
	masked_value = new_bits.join().to_i(2)
	# puts "value:  #{bit_string} (#{value})"
	# puts "mask:   #{mask}"
	# puts "result: #{new_bits.join()} (#{masked_value})"
	masked_value
end

instructions.each do |inst| 
	command, value = parseInsruction(inst)
	if (command == 'mask')
		mask = value
	else
		masked_value = applyMask(value, mask)
		puts "before: #{value} after: #{masked_value}"
		position = decodePosition(command)
		puts "memory[#{position}] = #{masked_value}"
		memory[decodePosition(command)] = masked_value
	end
end

puts "memory #{memory}"
sum = memory.compact.reduce { |sum, value| sum + value }

puts "sum #{sum}"



