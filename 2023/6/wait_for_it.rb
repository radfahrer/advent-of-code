require '../../file_reader.rb'
require '../../utils/parsing.rb'

times_string, distances_string = getInput({file_name: 'sample.txt'})

class Race
    def initialize(time, distance)
        @time = time
        @distance = distance
    end
    def solve()
        outcomes = @time.times.map do |ms|
            remaining = @time - ms
            distance = ms * remaining
        end
        puts "outcomes: #{outcomes}"
        puts "record: #{@distance}"
        outcomes.count{ |outcome| outcome > @distance}
    end
end

class BoatRaces
    def initialize(times_string, distances_string)
        time_label, times = times_string.split(":")
        times = Parser.toIntArray(times, /\s+/)
        distanc_label, distances = distances_string.split(":")
        distances = Parser.toIntArray(distances, /\s+/)
        @races = []
        times.each.with_index() do |time, index| 
            distance = distances[index]
            @races.push(Race.new(time, distance))
        end
    end
    def solve
        solution = @races.reduce(1) { |product, race| race.solve * product }
        puts "solution: #{solution}"
    end
end

boatRaces = BoatRaces.new(times_string, distances_string)

boatRaces.solve()