require '../file_reader.rb'

input = getInput()

counts = input.reduce([0,0,0,0,0,0,0,0,0,0,0,0]) do |counts, line|
	line.split('').each_with_index { |bit, index| counts[index] += bit.to_i}
	counts
end

gamma = counts.map { |count| count > input.size / 2 ? "1" : "0" }.join.to_i(2)
epsilon = counts.map { |count| count < input.size / 2 ? "1" : "0" }.join.to_i(2)

puts "gamma #{gamma}"
puts "epsilon #{epsilon}"

puts "power #{gamma * epsilon}"