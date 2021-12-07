require '../file_reader.rb'

input = getInput()

position = {y: 0, z:0, aim: 0}

commands = input.map {|line| line.split(/\s+/) }

commands.each do |command|
    direction, distance = command
	move = distance.to_i
    case direction
    when "forward"
        position[:y] += move
        position[:z] += position[:aim] * move
    when "down" 
        position[:aim] += move
    when "up"
        position[:aim] -= move
    end
end

puts position[:y] * position[:z]