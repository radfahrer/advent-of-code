require '../../file_reader.rb'

lines = getInput({file_name: 'sample.txt'})

$schematic = lines.map { |line| line.split("")}

def check_pos(x, y)
    if(x < 0 || y < 0 || y > ($schematic.size - 1) || x > ($schematic[y].size - 1))
        # ignore out of bounds
        return "."
    else
        return $schematic[y][x]
    end
end

def is_part_number?(x, y) 
    neighbors = [
        check_pos(x-1, y),
        check_pos(x-1, y-1),
        check_pos(x, y-1),
        check_pos(x+1, y-1),
        check_pos(x+1, y),
        check_pos(x+1, y+1),
        check_pos(x, y+1),
        check_pos(x-1, y+1)
    ]
    # puts "neighbors: #{neighbors}"
    return neighbors.any? {|value| value && value != "." && !(/\d/ =~ value) }
end

def solve(schematic)
    part_numbers = []
    other_numbers = []
    for y_index in (0...schematic.size)
        row = schematic[y_index]
        # puts "row: #{row}"
        number_accumulator = []
        is_part = false
        for x_index in (0...row.size) 
            symbol = row[x_index]
            # puts"symbol: #{symbol}"
            if(symbol =~ /\d/)
                number_accumulator.push(symbol)
                is_part ||= is_part_number?(x_index, y_index)
            else
                if(number_accumulator.length > 0) 
                    number = number_accumulator.join().to_i
                    if(is_part) 
                        part_numbers.push(number)
                    else 
                        other_numbers.push(number)
                    end
                    number_accumulator = []
                    is_part = false
                end
                is_part = false
            end
        end
    end
    puts "part numbers: #{part_numbers}"
    puts "other_numbers: #{other_numbers}"
    sum = part_numbers.reduce(0) { |sum, number| sum + number }
    puts "sum: #{sum}" 
end

solve($schematic)