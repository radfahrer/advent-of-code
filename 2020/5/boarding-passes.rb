#!/usr/bin/env ruby

lines = STDIN.read.split "\n"



def decodeRow(row_code)
    possible_rows = (0..127).to_a
    result = row_code.chars.reduce possible_rows do |rows, choice| 
        if(rows.size == 1) 
            rows
        else
            half = rows.size/2.0
            choice == 'F' ? rows.first(half) : rows.last(half)
        end
    end
    result.first
end

def decodeCol(col_code)
    possible_cols = (0..7).to_a
    result = col_code.chars.reduce possible_cols do |cols, choice| 
        puts "cols: #{cols} choice: #{choice}"
        if(cols.size == 1) 
            cols
        else
            half = cols.size/2.0
            choice == 'L' ? cols.first(half) : cols.last(half)
        end
    end
    result.first
end

def parseLine(line)
    match, row_code, col_code = line.match(/([FB]+)([LR]+)/).to_a
    row = decodeRow(row_code)
    col = decodeCol(col_code)
    id = row * 8 + col
    return [row, col, id]
end

data = lines.map { |line| parseLine(line) }

ids = data.map {|record| record.last} 

puts ids.max


