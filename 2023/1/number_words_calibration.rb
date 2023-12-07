require '../../file_reader.rb'

lines = getInput({file_name: 'sample2.txt'})

NUMBER_WORDS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
NUMBER_WORDS_PATTERN = /(one|two|three|four|five|six|seven|eight|nine)/
NUMBER_WORD_MAP = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
}

puts "lines: #{lines}"

def convertNumberWords(input)
    output = input
    while(NUMBER_WORDS_PATTERN =~ output) do 
    output = output.sub(NUMBER_WORDS_PATTERN) {|match| NUMBER_WORD_MAP[match]}
    end 
    return output
end

convertedLines = lines.map {|line| convertNumberWords(line)}

puts "converted lines: #{convertedLines}"

values = convertedLines.map do |line| 
    characters = line.chars
    digits = characters.select { |character| character =~ /[0-9]/ }
    "#{digits.first}#{digits.last}".to_i
end

puts "values: #{values}"

sum = values.reduce {|sum, val| sum + val}

puts "sum: #{sum}"
