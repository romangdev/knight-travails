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
    @flag = false
  end

  def get_starting_location(row, column)
    @start = [row, column]
    
    @start
  end

  def list_possible_moves(node)
    @possible_moves = []

    @possible_moves << [node[0] + 2, node[1] + 1] << [node[0] + 2, node[1] - 1] <<
    [node[0] - 2, node[1] + 1] << [node[0] - 2, node[1] - 1] << [node[0] + 1, node[1] + 2] <<
    [node[0] - 1, node[1] + 2] << [node[0] - 1, node[1] - 2] << [node[0] + 1, node[1] - 2]

    for i in 0...@possible_moves.length
      @possible_moves[i] = "nil" if @possible_moves[i][0] < 0 || @possible_moves[i][1] < 0 ||
      @possible_moves[i][0] > 7 || @possible_moves[i][1] > 7
    end

    @possible_moves.delete("nil")

    @possible_moves
  end

  def knight_moves(start, ending, level = 0)

    return print "\nStart is same as end:\n#{[start, ending]}\n" if start == ending

    @start = [start[0], start[1]]
    @start = Node.new(@start)
    queue = [@start]

    hold_original_children = []
    self.list_possible_moves(@start.data)
    @start.children = @possible_moves

    @start.children.each do |element|
      hold_original_children << element
    end

    all_paths = []

    print "\nORIGINAL CHILDREN: #{hold_original_children}\n"

    until queue.empty?
      node = queue.shift
      previous_parent = node

      self.list_possible_moves(node.data)
  
      node.children = @possible_moves

      for i in 0...node.children.length
        if node.children[i] == node.data
          node.children[i] = "nil"
        end
        unless node.previously_visited.length == 0
          for n in 0...node.previously_visited.length
            if node.children[i] == node.previously_visited[n]
              node.children[i] = "nil"
            end
          end
        end
      end

      node.children.delete("nil")

      print "\n\nParent: #{node.data}"
      print "\nChildren #{node.children}\n"

      node.children.each do |location|
        if location == ending
          @flag = true
          puts "\nCHILDREN CONTAIN ENDING LOCATION"

          node.previously_visited << node.data
          node.previously_visited << ending
          unless node.previously_visited[0] == start
            node.previously_visited.unshift(start)
          end
          all_paths << node.previously_visited

          puts "ALL PATHS\n"
          all_paths.each do |path|
            print "#{path}\n"
          end

          queue = []
          node = hold_original_children.shift
          node = Node.new(node)
          queue = [node]
          level = 0

          # set start node to next in list of the original start children
          # reset queue level and previously visited instance
          # will prob want to save each previosuly visitied instance in an arry
          # and return the shortest one

          # return
        else
          next
        end
      end

      if queue.empty?
        node.children.each do |location|
          location_node = Node.new(location)
          unless previous_parent.previously_visited.length == 0
            for i in 0...previous_parent.previously_visited.length
              location_node.previously_visited << previous_parent.previously_visited[i]
            end
          end
          location_node.previously_visited << node.data
          queue << location_node
        end
        level += 1
        print "\nLEVEL #{level} QUEUE: \n#{queue}"
      end
    end

    if @flag
      print "FLAGGG"
      return
    end
  end
end

class Node
  attr_accessor :data, :children, :previously_visited

  def initialize(data, previously_visited = [])
    @data = data
    @children = nil
    @previously_visited = previously_visited
  end
end

board = Board.new
board.generate_board

knight = Knight.new(board.board_arr)
knight.knight_moves([1,2], [1,2])
#5, 2 & 7, 5

#HANDLE ERRORS/EXCEPTIONS (INCLUDING INPUTTING STARTS AND ENDS OFF BOARD)