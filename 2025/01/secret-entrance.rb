require '../../utils/file_reader'

class Safe 
    def initialize()
        @current_position = 50
    end
    attr_accessor :current_position
end

the_safe = Safe.new()

class Puzzle
    def initialize(safe, instructions)
        @safe = safe
        @instructions = instructions
    end

    def solve()
        zero_count = @instructions.reduce(0) do |count, raw_instruction|
            instruction = Instruction.new(raw_instruction)
            difference = instruction.direction == 'L' ? -instruction.clicks : instruction.clicks
            new_position = (@safe.current_position + difference) % 100
            @safe.current_position = new_position
            if new_position == 0
                count + 1
            else
                count
            end
        end
        puts "the dial landed on zero #{zero_count} times"
    end
end

class Instruction 
    def initialize(raw_instruction)
        @direction = raw_instruction.chars.first
        @clicks = raw_instruction[1..-1].to_i
    end
    attr_reader :direction, :clicks
end

instructions = getInput()
puzzle = Puzzle.new(the_safe, instructions)
puzzle.solve()