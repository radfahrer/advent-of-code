require '../file_reader.rb'

input = getInput()

def og_filter(value, position) do
	first_bit = value.split('')[position]
	return first_bit == "1"
end

counts = input.reduce(Array.new(12, 0)) do |counts, line|
	line.split('').each_with_index { |bit, index| counts[index] += bit.to_i}
	counts
end

def find_oxygen_generator(values, position) do 
	if(values.size == 1) {
		return values.first
	} else {
		new_values = values.filter.with_index { |value, index| }
	}
end
