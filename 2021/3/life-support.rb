require '../file_reader.rb'

input = getInput()

class Solver
	def initialize(input)
		@input = input		
	end

	def most_common_bit(input, index)

		counts = input.reduce(Array.new(input.first.size, 0)) do |counts, line|
			line.split('').each_with_index { |bit, index| counts[index] += bit.to_i}
			counts
		end

		most_common_bits = counts.map do |count| 
			count >= input.size / 2.0 ? "1": "0"
		end
		
		return most_common_bits[index]
	end

	def least_common_bit(input, index)
		counts = input.reduce(Array.new(input.first.size, 0)) do |counts, line|
			line.split('').each_with_index { |bit, index| counts[index] += bit.to_i}
			counts
		end

		least_common_bit = counts.map do |count| 
			count < input.size / 2.0 ? "1": "0"
		end
		
		return least_common_bit[index]
	end

	def og_filter(most_common_bit, line, index) 
		return line[index] == most_common_bit
	end
	
	def find_oxygen_generator(remaining, index) 
		puts "remaining: #{remaining} index #{index}"
		if(remaining.size == 1 || index > 12) 
			return remaining.first
		else  
			mcb = most_common_bit(remaining, index)

			filtered = remaining.reduce([]) do |filtered, line|
				filtered.push(line) if(og_filter(mcb, line, index)) 
				filtered
			end

			return find_oxygen_generator(filtered, index + 1)
		end
	end

	def find_co2_scrubber(remaining, index)
		puts "remaining: #{remaining} index #{index}"
		if(remaining.size == 1 || index > 12) 
			return remaining.first
		else  
			lcb = least_common_bit(remaining, index)

			filtered = remaining.reduce([]) do |filtered, line|
				filtered.push(line) if(lcb == line[index]) 
				filtered
			end

			return find_co2_scrubber(filtered, index + 1)
		end
	end

	def solve()
		og_rating = find_oxygen_generator(@input, 0)
		puts "og rating: #{og_rating} (#{og_rating.to_i(2)})"
		cs_rating = find_co2_scrubber(@input, 0)
		puts "co2_scrubber_rating: #{cs_rating} (#{cs_rating.to_i(2)})"
		life_support_rating = og_rating.to_i(2) * cs_rating.to_i(2)
		puts "life support rating #{life_support_rating}"
	end
end

Solver.new(input).solve

