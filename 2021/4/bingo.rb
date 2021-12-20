require '../file_reader.rb'

input = getInput({raw: true})

class Board
	def initialize(board_string)
		rows = board_string.split("\n")
		@rows = rows.map { |row| row.strip.split(/\s+/) }
		@cols = @rows.size.times.to_a.map { |index| @rows.map { |row| row[index]} }
	end

	def check(picks)
		return checkRows(picks) || checkCols(picks)
	end

	def checkRows(picks)
		return @rows.any? do |row| 
			row.all? do |col| 
				picks.include? col 
			end
		end
	end

	def checkCols(picks)
		return @cols.any? do |col| 
			col.all? { |row| picks.include? row }
		end
	end

	def score(picks) 
		return @rows.reduce(0) do |score, row| 
			row.reduce(score) { |score, col| picks.include?(col) ? score : score + col.to_i}
		end
	end

	def to_s
		return @rows.map{ |row| row.map {|item| item.rjust(2, ' ')}.join(" ")}.join("\n")
	end
end

class BingoSolver
	def initialize(input)
		draws, *boards = input.split(/\n{2,}/)
		@draws = draws.split(",")
		@boards = boards.map{ |board| Board.new(board) }
		puts "board count #{@boards.size}"
	end

	def solve
		all_winning_boards = []
		(5...@draws.size).each do |index|
			picks = @draws.first(index+1)
			winning_board = @boards.reduce(all_winning_boards) do |winner, board|
				only_boards = all_winning_boards.map { |awb| awb[:board] }
				if(board.check(picks) && !only_boards.include?(board))
					all_winning_boards.push({draw: index, board: board, score: board.score(picks)})
				end
				all_winning_boards
			end
		end
		puts "number of winning boards: #{all_winning_boards.size}"
		first_win = all_winning_boards.first
		puts "First Win"
		puts "winning pick: #{first_win[:draw]}" 
		puts "winning board: \n#{first_win[:board]}"
		puts "board score: #{first_win[:score]}"
		puts "final score: #{first_win[:score] * @draws[first_win[:draw]].to_i}"
		last_win = all_winning_boards.last
		puts "Last Win"
		puts "winning pick: #{last_win[:draw]}" 
		puts "winning board: \n#{last_win[:board]}"
		puts "board score: #{last_win[:score]}"
		puts "final score: #{last_win[:score] * @draws[last_win[:draw]].to_i}"
	end

end


BingoSolver.new(input).solve