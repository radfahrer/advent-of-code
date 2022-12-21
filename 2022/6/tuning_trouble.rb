require '../../file_reader.rb'
require 'set'

data_stream = getInput({seperator: ""});

solution = data_stream.each_with_index.reduce(0) do |found_index, (character, index)|
	if (index >= 4) 
		sequence = data_stream[index-4...index]
		set = Set.new(sequence)
		unique = set.size == sequence.size;
		if(unique) 
			break index
		else 
			found_index 
		end
	else 
		found_index
	end
end

puts "start index: #{solution}"