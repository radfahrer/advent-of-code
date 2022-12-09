require '../../file_reader.rb'

drawing, moves = getInput({seperator: /^$/})

drawing_lines = drawing.split("\n");
*crates, aisles = drawing_lines

stack_count = aisles.split(/\s+/).last().to_i

def parse_level(level)
    return level.split("").each.with_index.reduce([]) do |out, (character, index)|
        out.push(character) if((index-1)% 4 == 0)
        out
    end
end

parsed = crates.reverse.reduce([]) do |stacks,level| 
    stacks.unshift(parse_level(level))
end

parsed.each {|line| puts line.join()}

def parse_move(move) 
    match, *groups = move.match(/move (\d+) from (\d+) to (\d+))
    groups
end

moves.each do |move| 
    parsed = parse_move(move)
end
