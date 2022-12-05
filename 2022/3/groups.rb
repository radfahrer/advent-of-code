require '../../file_reader.rb'

rucksacks = getInput()

letters = ('a'..'z').to_a + ('A'..'Z').to_a;

groups = rucksacks.reduce([[]]) do |groups, contents| 
    last_group = groups.pop()
    if(last_group.size < 3) 
        last_group.push(contents)
        groups.push(last_group)
    else
        groups.push(last_group)
        groups.push([contents])
    end
end


def find_match(first_contents, second_contents, third_contents)
    return first_contents.split("").reduce do |match, character| 
        if(second_contents.split("").include?(character) && third_contents.split("").include?(character)) 
            character
        else 
            match
        end
    end
end

answer = groups.reduce(0) do |sum, group|
    match = find_match(*group)
    priority = letters.find_index(match) + 1
    sum + priority
end

puts "answer: #{answer}"

