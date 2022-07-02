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
    print @start
    puts "\n"
  end

  # -2 , + 1 are nums
  def list_possible_moves
    @possible_moves = []
    @possible_moves << [@start[0] + 2, @start[1] + 1] << [@start[0] + 2, @start[1] - 1] <<
    [@start[0] - 2, @start[1] + 1] << [@start[0] - 2, @start[1] - 1] << [@start[0] + 1, @start[1] + 2] <<
    [@start[0] - 1, @start[1] + 2] << [@start[0] - 1, @start[1] - 2] << [@start[0] + 1, @start[1] - 2]
    print @possible_moves
    puts "\n\n"
    n = 0
    for i in 0...@possible_moves.length
      @possible_moves[i] = "nil" if @board[@possible_moves[i][n]][@possible_moves[i][n + 1]] == nil
      @possible_moves[i] = "nil" if @possible_moves[i][0] < 0 || @possible_moves[i][1] < 0
    end
    @possible_moves.delete("nil")
    print @possible_moves
    puts "\n"
  end
end

board = Board.new
board.generate_board

knight = Knight.new(board.board_arr)
knight.get_starting_location(1, 1)
knight.list_possible_moves