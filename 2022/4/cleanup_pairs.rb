require '../../file_reader.rb'

pairs = getInput()

def parse_elves(pair)
    return pair.split(',')
end

def parse_sections(elf)
    range_start, range_end = elf.split('-')
    return range_start..range_end
end

# monkey patch Range
class Range
    def fully_overlaps?(other_range)
        self.include?(other_range.first()) && self.include?(other_range.last())
    end
    def overlaps?(other_range)
        self.include?(other_range.first()) || self.include?(other_range.last())
    end
end

full_overlap_count = pairs.reduce(0) do |count, pair| 
    elf_one, elf_two = parse_elves(pair)
    elf_one_range = parse_sections(elf_one)
    elf_two_range = parse_sections(elf_two)
    # part 1
    # if(elf_one_range.fully_overlaps?(elf_two_range) || elf_two_range.fully_overlaps?(elf_one_range))
    # part 2
    if(elf_one_range.overlaps?(elf_two_range) || elf_two_range.overlaps?(elf_one_range))
        count += 1
    else
        count 
    end
end

puts "#{full_overlap_count} pairs fully overlap"
