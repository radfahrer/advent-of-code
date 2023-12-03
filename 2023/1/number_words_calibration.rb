require '../../file_reader.rb'

lines = getInput()

NUMBER_WORDS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
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
    NUMBER_WORDS.reduce(input) do |output, word| 
        number = NUMBER_WORD_MAP[word]
        output.gsub word, number.to_s
    end
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
