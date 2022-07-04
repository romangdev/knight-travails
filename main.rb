require_relative "board"
require_relative "node"
require_relative "knight"

board = Board.new
puts "\n- BOARD DISPLAY FOR REFERENCE -"
board.generate_board

knight = Knight.new(board.board_arr)
knight.knight_moves([2,6], [7,3])
puts "\n"