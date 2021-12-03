require '../file_reader.rb'

input = getInput()

result = input.map(&:to_i).reduce({count: 0, last: nil}) do |memo, depth|
    last = memo[:last]
    memo[:count] += 1 if(last && last < depth)
    memo[:last] = depth
    memo
end

puts "count: #{result[:count]}" 