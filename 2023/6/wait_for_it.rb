require '../../file_reader.rb'

times_string, distances_string = getInput({file_name: 'sample.txt'})
stripper = Proc.new {|part| part.strip}
class Race
    def initialize(time, distance)
        @time = time
        @distance = distance
    end
end

class BoatRaces
    def initialize(times_string, distances_string)
        @races = []
        time_label, times = times_string.split(":").map stripper
        times = times.split(/\s+/).map {|number| number.to_i}
        distanc_label, distances = distances_string.split(":").map stripper
        puts "times: #{times}"
        puts "distances: #{distances}"
    end
end

BoatRaces.new(times_string, distances_string)