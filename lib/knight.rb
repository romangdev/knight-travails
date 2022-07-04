# frozen_string_literal: true

require_relative 'board'
require_relative 'node'

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
      @possible_moves[i] = 'nil' if @possible_moves[i][0].negative? || @possible_moves[i][1].negative? ||
                                    @possible_moves[i][0] > 7 || @possible_moves[i][1] > 7
    end

    @possible_moves.delete('nil')

    @possible_moves
  end

  def knight_moves(start, ending)
    # Return from method immediately if one or both of the arguments a user passes to the knight_moves
    # method is not a location on the board.
    if start[0].negative? || start[0] > 7 || start[1].negative? || start[1] > 7 ||
       ending[0].negative? || ending [0] > 7 || ending[1].negative? || ending [1] > 7
      puts "\nOne or both of your knight start and end arguments is not a location on the board."
      return
    end

    return print "\nShortest path (you're already on the end square!):\n#{start}\n" if start == ending

    @start = [start[0], start[1]]
    @start = Node.new(@start)

    # queue is to be used for breadth first traversal
    queue = [@start]

    hold_original_children = []
    list_possible_moves(@start.data)
    @start.children = @possible_moves

    # Check to see if any possible moves of the start square include the end square
    @start.children.each do |element|
      if element == ending
        return print "\nShortest path takes 1 move (you can jump straight to the end square!):\n#{[start, ending]}\n"
      end

      hold_original_children << element
    end

    all_paths = []

    until queue.empty?
      node = queue.shift
      previous_parent = node

      list_possible_moves(node.data)

      node.children = @possible_moves

      # For all possible moves a square can make, do not include in that array its parent square
      # or any square it has already visited before on its path
      for i in 0...node.children.length
        node.children[i] = 'nil' if node.children[i] == node.data
        next if node.previously_visited.length == 0

        for n in 0...node.previously_visited.length
          node.children[i] = 'nil' if node.children[i] == node.previously_visited[n]
        end
      end
      node.children.delete('nil')

      # When you find the ending square in the children (possible moves) of a node down one tree path
      # then add the entire sequence path (from start to finish) to an array of arrays called all_paths
      node.children.each do |location|
        if location == ending
          node.previously_visited << node.data
          node.previously_visited << ending
          node.previously_visited.unshift(start) unless node.previously_visited[0] == start
          all_paths << node.previously_visited

          # When you've traversed and gathered all shortest tree paths for each original child of the
          # start position, remove the last element of all_paths array to handle a duplication issue,
          # then return the shortest path out of all paths in the all_paths array
          if hold_original_children.empty?
            puts "\n"
            all_paths.delete_at(-1)

            for i in 0...all_paths.length
              unless all_paths[i + 1].nil?
                shortest = if all_paths[i].length < all_paths[i + 1].length
                             all_paths[i]
                           else
                             all_paths[i + 1]
                           end
              end
              return print "\nShortest path takes #{shortest.length - 1} moves: #{shortest}\n"
            end
            return shortest
          end

          # Reset the queue, and select new starting node (based on the original children of the start
          #  location) when one path has been added to all_paths
          queue = []
          node = hold_original_children.shift
          node = Node.new(node)
          queue = [node]
        else
          next
        end
      end

      # If the queue ever becomes empty, then fill it with the next set of children
      next unless queue.empty?

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
    end
  end
end
