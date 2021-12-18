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
			row.all? { |col| picks.include? col }
		end
	end

	def checkCols(picks)
		return @cols.any? do |col| 
			col.all? { |row| picks.include? row }
		end
	end

	def to_s
		return @rows.map{ |row| row.join(" ")}.join("\n")
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
		(5...@draws.size).each do |index|
			picks = @draws.first(index+1)
			winning_board = @boards.reduce { |winner, board| winner || board.check(picks)}
			if(winning_board) 
				puts "winning pick: #{@draws[index]}" 
				puts "picks: #{picks}"
				puts "winning board: \n #{winning_board}"
				return
			end
		end
	end

end


BingoSolver.new(input).solve