class Board
  def initialize 
  end

  def generate_board
    board_arr = []
    8.times {board_arr << [0, 1, 2, 3, 4, 5, 6, 7]}
    
    count = 7
    while count >= 0
      print "Row #{count}: #{board_arr[count]}\n"
      count -= 1
    end
  end
end

board = Board.new
board.generate_board