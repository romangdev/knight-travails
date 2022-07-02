class Board
  attr_accessor :board_arr
  
  def initialize 
    @board_arr = []
    8.times {@board_arr << [0, 1, 2, 3, 4, 5, 6, 7]}
  end

  def generate_board
    count = 7
    while count >= 0
      print "Row #{count}: #{@board_arr[count]}\n"
      count -= 1
    end
  end
end

class Knight
  def initialize(board)
    @board = board
  end

  def get_starting_location(row, column, board = @board)
    @start = [row, column]
    print "\nStart: #{@start}\n"
  end

  def list_possible_moves
    @possible_moves = []
    @possible_moves << [@start[0] + 2, @start[1] + 1] << [@start[0] + 2, @start[1] - 1] <<
    [@start[0] - 2, @start[1] + 1] << [@start[0] - 2, @start[1] - 1] << [@start[0] + 1, @start[1] + 2] <<
    [@start[0] - 1, @start[1] + 2] << [@start[0] - 1, @start[1] - 2] << [@start[0] + 1, @start[1] - 2]
    for i in 0...@possible_moves.length
      @possible_moves[i] = "nil" if @possible_moves[i][0] < 0 || @possible_moves[i][1] < 0 ||
      @possible_moves[i][0] > 7 || @possible_moves[i][1] > 7
    end
    @possible_moves.delete("nil")
    print "Possible moves: #{@possible_moves}"
    puts "\n"
  end
end

board = Board.new
board.generate_board

knight = Knight.new(board.board_arr)
knight.get_starting_location(1, 1)
knight.list_possible_moves