# This class is used to generate a visual chess board for the user's reference
class Board
  attr_accessor :board_arr, :possible_moves

  def initialize
    @board_arr = []
    8.times { @board_arr << [0, 1, 2, 3, 4, 5, 6, 7] }
  end

  # Generates an 8 x 8 chess board numbered with indices from 0 - 7
  def generate_board
    count = 7
    while count >= 0
      print "Row #{count}: #{@board_arr[count]}\n"
      count -= 1
    end
  end
end
