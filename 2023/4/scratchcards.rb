require '../../file_reader.rb'

lines = getInput({file_name: 'sample.txt'})

class Card 
    def initialize(card_string)
        card_number_string, numbers_string = card_string.split(":")
        winning_numbers_string, scratched_numbers_string = numbers_string.split("|").map {|part|part.strip}
        @winning_numbers = winning_numbers_string.split(/\s+/).map {|number| number.to_i}
        # puts "winning numbers: #{@winning_numbers}"
        @scratched_numbers = scratched_numbers_string.split(/\s+/).map{|number| number.to_i}
        # puts "scratched numbers: #{@scratched_numbers}"
    end

    def score
        count = @scratched_numbers.reduce(0) do |count, number| 
            if @winning_numbers.include? number 
                count + 1
            else
                count
            end
        end
        # puts "count: #{count}"
        score = calcScore(count)
        # puts "score: #{score}"
    end

    private

    def calcScore(count)
        if(count == 0) 
            return 0
        else
            score = 1
            (count - 1).times { score *= 2}
            return score 
        end
    end
end

cards = lines.map {|line| Card.new(line)}

total = cards.reduce(0) {|total, card| total += card.score }

puts "total: #{total}"