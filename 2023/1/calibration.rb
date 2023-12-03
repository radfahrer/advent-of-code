require '../../file_reader.rb'

lines = getInput()

puts "calibrations"

values = lines.map do |line| 
    characters = line.chars
    digits = characters.select { |character| character =~ /[0-9]/ }
    "#{digits.first}#{digits.last}".to_i
end

puts "values: #{values}"

sum = values.reduce {|sum, val| sum + val}

puts "sum: #{sum}"