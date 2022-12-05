require '../../file_reader.rb'

elves = getInput({seperator: /^$/});

elf_calories = elves.map do |elf| 
    elf.split("\n").map{|num| num.to_i}.reduce{|sum, num| sum + num}
end

puts elf_calories.sort.last(3).reduce{|sum, num| sum + num}
