require '../../file_reader.rb'

games = getInput({file_name: 'sample.txt'})

$bag_cubes = { "red" => 12, "green" => 13, "blue" => 14 }

class Hand
    def initialize
        @red_count = 0
        @green_count = 0
        @blue_count = 0
    end

    def is_possible? 
        return @red_count <= $bag_cubes["red"] && @green_count <= $bag_cubes['green'] && @blue_count <= $bag_cubes['blue']
    end

    attr_writer :red_count, :green_count, :blue_count
end

class Game 
    def initialize(game_string)
        game_number_string, hands_string = game_string.split(":");
        @number = game_number_string.split(" ").last.to_i
        @hands = parse_hands(hands_string) || []
    end

    def is_possible? 
        return @hands.all? { |hand| hand.is_possible?}
    end

    attr_reader :number

    private

    def parse_hands(hands_string)
        hands = hands_string.split(";")
        return hands.map do |hand_string|
            colors = hand_string.split(/,\s/)
            puts "colors: #{colors}"

            hand = Hand.new()
            colors.reduce(hand) do |hand, color_string| 
                count, color = color_string.split(" ")
                
                case color
                when "red"
                    hand.red_count = count.to_i
                when "green"
                    hand.green_count = count.to_i
                when "blue"
                    hand.blue_count = count.to_i
                end
                
                hand
                
            end
        end
    end
    
end 

def solve(games)
    return games.reduce(0) do |solution, game_string| 
        game = Game.new(game_string)
        if(game.is_possible?)
            solution += game.number
        end
        solution
    end
end

solution = solve(games)

puts "solution: #{solution}"