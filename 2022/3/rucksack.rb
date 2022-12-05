require '../../file_reader.rb'

rucksacks = getInput()

letters = ('a'..'z').to_a + ('A'..'Z').to_a;

def bisect(string)
    characters = string.split("")
    half = characters.size / 2
    first_half = characters.first(half)
    second_half = characters.last(half)
    return first_half, second_half
end

def find_match(first_compartment, second_compartment)
    return first_compartment.reduce do |match, character| 
        if(second_compartment).include?(character) 
            character
        else 
            match
        end
    end
end

answer = rucksacks.reduce(0) do |sum, contents|
    first_compartment, second_compartment = bisect(contents)
    match = find_match(first_compartment, second_compartment)
    puts "match #{match}"
    priority = letters.find_index(match) + 1
    puts "priority #{priority}"
    sum + priority
end

puts "answer: #{answer}"