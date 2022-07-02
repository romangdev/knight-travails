class Board
  attr_accessor :board_arr, :possible_moves
  
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

  def get_starting_location(row, column)
    @start = [row, column]
    # print "\nStart: #{@start}\n"
    
    @start
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
    # print "Possible moves: #{@possible_moves}"
    # puts "\n"
    # puts "\n"

    @possible_moves
  end

  def knight_moves(start, ending)
    @start = [start[0], start[1]]
    node = Node.new(@start)
    self.list_possible_moves
    node.children = @possible_moves

    print node.data
    puts "\n"
    print node.children

    node.children.each do |location|
      if location == ending
        flag = true
        puts "\nCHILDREN CONTAIN ENDING LOCATION"
        return flag
      else
        next
      end
    end
  end
end

class Node
  attr_accessor :data, :children

  def initialize(data)
    @data = data
    @children = nil
  end
end

board = Board.new
board.generate_board

knight = Knight.new(board.board_arr)
knight.get_starting_location(1, 2)
knight.list_possible_moves
knight.knight_moves([1,2], [0,0])