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
        from_stack_index = from_stack.index{|box| /\w/.match(box)} || 0
        to_stack_index = to_stack.index{|box| /\w/.match(box)} || to_stack.size
        crate = from_stack[from_stack_index]
        from_stack.delete_at(from_stack_index)
        to_stack.insert(to_stack_index, crate)
        # reset stacks
        self.cleanup()
    end

    def cleanup
        max_stack_size = @stacks.map { |stack| stack.count {|box| box =~ /\w/} }.max()
        @stacks = @stacks.map do |stack| 
            if(stack.size > max_stack_size)
                stack.last(max_stack_size)
            elsif(stack.size < max_stack_size)
                diff = max_stack_size - stack.size
                diff.times { stack.unshift(" ")}
                stack
            else 
                stack
            end
        end
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
    return groups.map { |group| group.to_i }
end

stacks = Stacks.new(crates)

puts "======= start ======="
moves.split("\n").each do |move| 
    count, from_column, to_column = parse_move(move)
    count.times do 
        stacks.move(from_column -1 , to_column -1)
    end        
end
puts "stacks: \n#{stacks.to_s}" 
