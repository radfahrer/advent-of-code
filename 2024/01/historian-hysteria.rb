require '../../file_reader.rb'

lines = getInput()

puts lines

puts "lines lenght: #{lines.length}"

pairs = lines.map {|line| line.split(/\s+/).map {|number| number.to_i}}

list_one = pairs.map {|pair| pair[0]}
list_two = pairs.map {|pair| pair[1]}

list_one_sorted = list_one.sort()
list_two_sorted = list_two.sort()


distances = (0..lines.length-1).to_a.map { |idx| list_one_sorted[idx] - list_two_sorted[idx]}

puts "distances: #{distances}"

absolute_distances = distances.map {|distance| distance.abs}

puts "absolute distance: #{absolute_distances}"

solution = absolute_distances.reduce(0) {|sum, num| sum + num}

puts "solution: #{solution}"