require '../../file_reader.rb'

lines = getInput()

NUMBER_WORDS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
NUMBER_WORD_MATCH = /(one|two|three|four|five|six|seven|eight|nine)/
LAST_NUMBER_WORD_MATCH = /(eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)/
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

def convertNumberWords(input)
    first_replaced = input.sub(NUMBER_WORD_MATCH) {|word| NUMBER_WORD_MAP[word]}
    last_replaced = (first_replaced.reverse.sub(LAST_NUMBER_WORD_MATCH) {|word| NUMBER_WORD_MAP[word.reverse]}).reverse
    return last_replaced
end

convertedLines = lines.map {|line| convertNumberWords(line)}

values = convertedLines.map do |line| 
    characters = line.chars
    digits = characters.select { |character| character =~ /[0-9]/ }
    "#{digits.first}#{digits.last}".to_i
end

sum = values.reduce {|sum, val| sum + val}

puts "sum: #{sum}"
