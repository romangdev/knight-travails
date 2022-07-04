# This class is used to generate a visual chess board for the user's reference
class Board
  attr_accessor :board_arr, :possible_moves
  
  def initialize 
    @board_arr = []
    8.times {@board_arr << [0, 1, 2, 3, 4, 5, 6, 7]}
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

# The knight class handles the main knight_moves method the program is built for, as well as additional
# methods to support said main method
class Knight
  def initialize(board)
    @board = board
    @flag = false
  end

  # Used in knight_moves method to retrieve a starting position and save as instance variable 
  def get_starting_location(row, column)
    @start = [row, column]
    
    @start
  end

  # Generate array of all possible squares a knight can jump to based on its current location
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

    # Return from method immediately if one or both of the arguments a user passes to the knight_moves
    # method is not a location on the board.
    if start[0] < 0 || start[0] > 7 || start[1] < 0 || start[1] > 7 ||
      ending[0] < 0 || ending [0] > 7 || ending[1] < 0 || ending [1] > 7
      puts "\nOne or both of your knight start and end arguments is not a location on the board."
      return
    end

    return print "\nShortest path (you're already on the end square!):\n#{start}\n" if start == ending

    @start = [start[0], start[1]]
    @start = Node.new(@start)

    # queue is to be used for breadth first traversal
    queue = [@start]

    hold_original_children = []
    self.list_possible_moves(@start.data)
    @start.children = @possible_moves

    # Check to see if any possible moves of the start square include the end square
    @start.children.each do |element|
      return print "\nShortest path (you can jump straight to the end square!):\n#{[start, ending]}\n" if element == ending
      hold_original_children << element
    end

    all_paths = []

    until queue.empty?
      node = queue.shift
      previous_parent = node

      self.list_possible_moves(node.data)
  
      node.children = @possible_moves

      # For all possible moves a square can make, do not include in that array its parent square
      # or any square it has already visited before on its path
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

      # When you find the ending square in the children (possible moves) of a node down one tree path
      # then add the entire sequence path (from start to finish) to an array of arrays called all_paths
      node.children.each do |location|
        if location == ending
          node.previously_visited << node.data
          node.previously_visited << ending
          unless node.previously_visited[0] == start
            node.previously_visited.unshift(start)
          end
          all_paths << node.previously_visited

          # When you've traversed and gathered all shortest tree paths for each original child of the 
          # start position, remove the last element of all_paths array to handle a duplication issue,
          # then return the shortest path out of all paths in the all_paths array
          if hold_original_children.empty?
            puts "\n"
            all_paths.delete_at(-1)

            puts "ALL PATHS:"
            all_paths.each do |path|
              print "#{path}\n"
            end

            for i in 0...all_paths.length
              unless all_paths[i + 1] == nil
                if all_paths[i].length < all_paths[i + 1].length
                  shortest = all_paths[i]
                else
                  shortest = all_paths[i + 1]
                end
              end
              return print "\nShortest path: #{shortest}\n"
            end
            return 
          end

          # Reset the queue and level, and select new starting node (based on the original children of the start
          #  location) when one path has been added to all_paths
          queue = []
          node = hold_original_children.shift
          node = Node.new(node)
          queue = [node]
          level = 0 
        else
          next
        end
      end

      # If the queue ever becomes empty, then fill it with the next set of children
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
      end
    end
  end
end

# Node class is used to generate each visited chess square as a node with attributes to be saved
# so that we can traverse a tree of nodes, allowing us to find the shortest path a knight can take
# from start to finish
class Node
  attr_accessor :data, :children, :previously_visited

  def initialize(data, previously_visited = [])
    @data = data
    @children = nil
    @previously_visited = previously_visited
  end
end

board = Board.new
puts "\n- BOARD DISPLAY FOR REFERENCE -"
board.generate_board

knight = Knight.new(board.board_arr)
knight.knight_moves([0,1], [7,2])
puts "\n"