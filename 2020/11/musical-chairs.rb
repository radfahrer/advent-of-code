#!/usr/bin/ruby

rows = $stdin.read.split(/\n/).map { |row| row.chars }

def validPosition?(x, y, rows) 
    row_count = rows.size
    col_count = rows.first.size

    x_is_out_of_bounds = x < 0 || x >= col_count 
    y_is_out_of_bounds = y < 0 || y >= row_count

    return !(x_is_out_of_bounds || y_is_out_of_bounds)
end

def getValue(x, y, rows)
    rows[y][x]
end

def countNeighbors(x, y, rows)
    neighborOffsets = [[-1, -1], [-1, 0], [-1, 1], [0,-1], [0,1], [1, -1], [1, 0], [1,1] ]
    neighborOffsets.reduce(0) do |count, offset|
        x_offset, y_offset = offset
        neighbor_x = x + x_offset
        neighbor_y = y + y_offset
        if(validPosition?(neighbor_x, neighbor_y, rows)) 
            value = getValue(neighbor_x, neighbor_y, rows)
            value == '#' ? count + 1 : count
        else
            count
        end
    end
end

def newValue(x, y, rows) 
    current_value = getValue(x, y, rows)
    case current_value
    when 'L'
        countNeighbors(x, y, rows) == 0 ? '#' : 'L'
    when '#'
        countNeighbors(x, y, rows) >= 4 ? 'L' : '#'
    else
        '.'
    end
end

def cloneRows(rows)
    rows.map { |row| row.dup }
end

def shuffle(rows) 
    row_count = rows.size
    col_count = rows.first.size
    
    new_rows = cloneRows(rows)
    
    row_count.times do |y| 
        col_count.times do |x|
            new_rows[y][x] = newValue(x, y, rows)
        end
    end

    new_rows
end

def printRows(rows)
    rows.each { |row| puts row.join() }
end

def same? (old_rows, new_rows) 
    if(old_rows && new_rows) 
        row_count = old_rows.size
        col_count = old_rows.first.size
        same = true
        row_count.times do |y| 
            col_count.times do |x|
                same = false if(getValue(x,y, old_rows) != getValue(x,y, new_rows))
            end
        end
        return same
    else
        return false
    end
end

def countOcupied(rows)
    rows.reduce (0) { |count, row| count + row.count {|col| col == "#"} }
end

new_rows = nil
old_rows = cloneRows(rows)

done = false
until(done)
    new_rows = shuffle(old_rows)
    # puts "\n"
    # printRows(new_rows)
    done = same?(old_rows, new_rows)
    old_rows = new_rows.clone
end

puts "ocupied seats: #{countOcupied(new_rows)}"
