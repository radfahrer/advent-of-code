#!/usr/bin/ruby

def validate (line)
	string,pos1,pos2,letter,password = /(\d+)-(\d+)\s+([a-z]):\s+(\w+)/.match(line).to_a
	index1 = pos1.to_i - 1
	index2 = pos2.to_i - 1
	at_pos1 = password[index1, 1] == letter
	at_pos2 = password[index2, 1] == letter
	at_pos1 ^ at_pos2
end

input = $stdin.read

lines = input.split(/\n/)

valid_lines = lines.select {|line| validate(line)}

puts "valid passwords: #{valid_lines.length}"
