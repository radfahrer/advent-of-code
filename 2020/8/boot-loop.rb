#!/usr/bin/env ruby

instructions = STDIN.read.split(/\n/)


def solve(instructions) 
	accumulator = 0
	index = 0 
	history = {};

	commands = instructions.map do |instruction| 
		match, opperation, argument = /(\w+)\s+([+-]\d+)/.match(instruction).to_a
		[opperation, argument.to_i]
	end

	while(history[index] == nil) do 
		opperation, argument = commands[index]
		history[index] = opperation
		case opperation
		when 'nop'
			index += 1
		when 'acc'
			index += 1
			accumulator += argument
		when 'jmp'
			index += argument
		end
	end

	accumulator
end

puts "last value of accumulator: #{solve(instructions)}"



