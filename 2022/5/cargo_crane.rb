require '../../file_reader.rb'

drawing, moves = getInput({seperator: /^$/})

drawing_lines = drawing.split("\n")
*crates, aisles = drawing_lines

stack_count = aisles.split(/\s+/).last().to_i


class Stacks 
    def initialize(crates)
        parsed = crates.reverse.reduce([]) do |stacks,level| 
            stacks.unshift(self.parse_level(level))
        end
        parsed.each {|line| puts line.join()}

        @stack_count = parsed.last().size
        stacks = Array.new(@stack_count, [])
        @stacks = parsed.reduce(stacks) do |stacks, level|
            level.each_with_index do |crate, index|
                stacks[index].push(crate)
            end
            stacks
        end
        puts @stacks;
    end
    def to_s
        "not defined yet"
    end
    def parse_level(level)
        return level.split("").each.with_index.reduce([]) do |out, (character, index)|
            out.push(character) if((index-1)% 4 == 0)
            out
        end
    end
    
end


def parse_move(move) 
    match, *groups = move.match(/move (\d+) from (\d+) to (\d+)/).to_a
    groups
end

Stacks.new(crates)

moves.split("\n").each do |move| 
    count, from_index, to_index = parse_move(move)
end
