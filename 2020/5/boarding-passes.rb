#!/usr/bin/env ruby

lines = STDIN.read.split "\n"

def decodeRow(row_code)
    possible_rows = 0...127
    result = row_code.chars.reduce possible_rows do |rows, choice| 
        if(rows.size == 1) 
            rows
        else
            choice == 'F' ? rows.first(rows.size/2) : rows.last(rows.size/2)
        end
    end
    result.first
end

def decodeCol(col_code)
    possible_cols = 0...7
    result = col_code.chars.reduce possible_cols do |cols, choice| 
        if(cols.size == 1) 
            cols
        else 
            choice == 'L' ? cols.first(cols.size/2) : cols.last(cols.size/2)
        end
    end
    result.first
end

def parseLine(line)
    match, row_code, col_code = line.match(/([FB]+)([LR]+)/).to_a
    #puts "match #{match} row: #{row_code}, col: #{col_code}"
    row = decodeRow(row_code)
    col = decodeCol(col_code)
    id = row * 8 + col
    puts "#{line} row: #{row}, col: #{col}, id: #{id}"
    return [row, col, id]
end

data = lines.map { |line| parseLine(line) }

ids = data.map {|record| record.last} 

puts ids.max

