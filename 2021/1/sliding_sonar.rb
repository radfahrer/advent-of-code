require '../file_reader.rb'

input = getInput().map(&:to_i);

count = 0
prev_sum = nil
input.each_with_index do |depth, index|
    if(index.between?(1, input.size-3)) then
        prev = input[index - 1]
        next_depth = input[index + 1] 
        following_depth = input[index + 2]
        sum = prev + depth + next_depth
        next_sum = depth + next_depth + following_depth
        count += 1 if(sum < next_sum)
    end
end

puts "increase count: #{count}"