#!/usr/bin/ruby

def validate (line)
	string,min,max,letter,password = /(\d+)-(\d+)\s+([a-z]):\s+(\w+)/.match(line).to_a
	password.count(letter).between?(min.to_i,max.to_i)
end

input = $stdin.read

lines = input.split(/\n/)

valid_lines = lines.select {|line| validate(line)}

puts "valid passwords: #{valid_lines.length}"
