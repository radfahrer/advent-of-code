require '../file_reader.rb'

input = getInput()

position = {y: 0, z:0}

commands = input.map {|line| line.split(/\s+/) }

commands.each do |command|
    direction, distance = command

    case direction
    when "forward"
        position[:y] += distance.to_i
    when "down" 
        position[:z] += distance.to_i
    when "up"
        position[:z] -= distance.to_i
    end
end

puts position[:y] * position[:z]