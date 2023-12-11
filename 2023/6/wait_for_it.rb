require '../../file_reader.rb'
require '../../utils/parsing.rb'

times_string, distances_string = getInput({file_name: 'sample.txt'})
class Race
    def initialize(time, distance)
        @time = time
        @distance = distance
    end
    def solve()
        puts "time"
    end
end

class BoatRaces
    def initialize(times_string, distances_string)
        time_label, times = times_string.split(":").map &$stripper
        times = Parser.toIntArray(times)
        distanc_label, distances = distances_string.split(":").map &$stripper
        distances = Parser.toIntArray(distances)
        @races = []
        times.each.with_index() do |time, index| 
            distance = distances[index]
            @races.push(Race)
        end
    end
    def solve
        puts "solution: #{@races.first.solve()}"
    end
end

boatRaces = BoatRaces.new(times_string, distances_string)

boatRaces.solve()