#!/usr/bin/ruby
input = $stdin.read

lines = input.split(/\n/)

def countTrees(right, down, lines)
	line_length = lines[0].length
	line_number = 1
	pos = 1;
	lines.slice(1, lines.length).count do |line|
		skip = down > 1 ? line_number % down  != 0 : false
		line_number += 1
		pos = (pos + right) % (line_length) unless skip
		index = pos - 1
		!skip && line.split("").at(index) == "#"
	end
end

slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]

answer = slopes.reduce 1 do |product, slope|
	right, down = slope
	product * countTrees(right, down, lines)
end

puts answer
