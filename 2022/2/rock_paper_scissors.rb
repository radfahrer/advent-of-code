require '../../file_reader.rb'

guide = getInput()

class Hand
    include Comparable
    attr :value, :shape
    def initialize(code)
        case code
        when /[AX]/
            @shape = :rock
            @value = 1
        when /[BY]/
            @shape = :paper
            @value = 2 
        when /[CZ]/
            @shape = :scissors
            @value = 3
        end
    end

    def <=>(other)
        diff = @value - other.value;
        if(diff.abs() == 2)
            diff/-2
        else
            diff
        end
    end 
end 

class Round
    def initialize(opponent_move, your_move)
        @opponent_hand = Hand.new(opponent_move)
        @your_hand = Hand.new(your_move)
    end
    def outcome
        if (@your_hand > @opponent_hand)
            "win"
        elsif (@your_hand < @opponent_hand)
            "lose"
        else
            "draw"
        end
    end
    def score
        score = case self.outcome()
        when "win"
            6
        when "draw"
            3
        when "lose"
            0
        end
        score += @your_hand.value
    end
    def to_s 
        "you: #{@your_hand.shape} opponent: #{@opponent_hand.shape} outcome: #{self.outcome()} score #{self.score()}"
    end
end

rounds = guide.map do  |line| 
    opponent_move, your_move = line.split(/\s/)
    Round.new(opponent_move, your_move)
end

total_score = rounds.map{|round| round.score()}.reduce{|sum, num| sum + num}
puts "total score = #{total_score}"