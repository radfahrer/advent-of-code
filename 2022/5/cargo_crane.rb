require '../../file_reader.rb'

drawing, moves = getInput({seperator: /^$\n/})

drawing_lines = drawing.split("\n")
*crates, aisles = drawing_lines

stack_count = aisles.split(/\s+/).last().to_i

def grid_transpose(grid)
    max_row_size = grid.map {|row| row.size}.max()
    memo = Array.new(max_row_size) {
        Array.new
    }
    new_grid = grid.reduce(memo) do |columns, row| 
        row.each_with_index do |value, index| 
            columns[index].push(value)
        end
        columns
    end
    return new_grid
end

class Stacks 
    def initialize(crates)
        parsed = crates.reverse.reduce([]) do |stacks,level| 
            stacks.unshift(self.parse_level(level))
        end
        parsed.each {|line| puts line.join()}

        @stacks = grid_transpose(parsed)
    end


    def to_s
        grid_transpose(@stacks).map{|layer| layer.join()}.join("\n")
    end

    def move(from_index, to_index)
        from_stack = @stacks[from_index]
        to_stack = @stacks[to_index]
        puts "from #{from_index} to #{to_index}"
        puts "from stack #{from_stack}"
        puts "to stack #{to_stack}"
        from_stack_index = from_stack.index{|box| /\w/.match(box)}
        to_stack_index = to_stack.index{|box| /\w/.match(box)} + 1
        crate = from_stack[from_stack_index]
        puts "crate #{crate}"
        from_stack.delete_at(from_index)
        to_stack.insert(to_index, crate)
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
    return groups.map {|group| group.to_i}
end

stacks = Stacks.new(crates)

puts "======= start ======="
moves.split("\n").first(2).each do |move| 
    count, from_column, to_column = parse_move(move)
    count.times do 
        puts "stacks: \n#{stacks.to_s}"
        stacks.move(from_column -1 , to_column - 1)
        puts "stacks: \n#{stacks.to_s}" 
    end        
end
