require '../file_reader.rb'

input = getInput()

class Solver
	def initialize(input)
		@input = input
		counts = input.reduce(Array.new(12, 0)) do |counts, line|
			line.split('').each_with_index { |bit, index| counts[index] += bit.to_i}
			counts
		end
		@most_common_bits = counts.map { |count| count >= input.size / 2 ? "1": "0"}
	end

	def og_filter(line, index) 
		return line[index] == @most_common_bits[index]
	end
	
	def find_oxygen_generator(remaining, index) 
		puts "remaining: #{remaining} index #{index}"
		if(remaining.size == 1 || index > 12) 
			return remaining.first
		else  
			filtered = remaining.reduce([]) do |filtered, line|
				filtered.push(line) if(og_filter(line, index)) 
				filtered
			end

			return find_oxygen_generator(filtered, index + 1)
		end
	end

	def solve()
		og_rating = find_oxygen_generator(@input, 0)
		puts "og rating: #{og_rating}"
	end
end

Solver.new(input).solve

