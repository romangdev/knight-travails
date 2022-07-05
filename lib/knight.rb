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
    return if handle_off_board_args(start, ending) == 1

    return print "\nShortest path (you're already on the end square!):\n#{start}\n" if start == ending

    @start = [start[0], start[1]]
    @start = Node.new(@start)

    # queue is to be used for breadth first traversal
    queue = [@start]

    hold_original_children = []
    list_possible_moves(@start.data)
    @start.children = @possible_moves

    return if check_one_edge_path(@start, ending, hold_original_children) == 1

    all_paths = []

    until queue.empty?
      node = queue.shift
      previous_parent = node
      list_possible_moves(node.data)
      node.children = @possible_moves
      remove_visited_squares(node)
      node.children.delete('nil')

      # When you find the ending square in the children (possible moves) of a node down one tree path
      # then add the entire sequence path (from start to finish) to an array of arrays called all_paths
      node.children.each do |location|
        if location == ending
          fill_all_paths(node, location, ending, all_paths, start)

          # Execute once all shortest child paths have been found
          return if remove_uneeded_final_path(hold_original_children, all_paths) == 1

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

      next unless queue.empty?

      fill_queue_with_children(node, previous_parent, queue)
    end
  end

  private

  # For all possible moves a square can make, do not include in that array its parent square
  # or any square it has already visited before on its path
  def remove_visited_squares(node)
    for i in 0...node.children.length
      node.children[i] = 'nil' if node.children[i] == node.data
      next if node.previously_visited.length == 0

      for n in 0...node.previously_visited.length
        node.children[i] = 'nil' if node.children[i] == node.previously_visited[n]
      end
    end
  end

  # Return the shortest path from the all_paths array
  def get_shortest_path(all_paths)
    shortest = all_paths[0]
    for i in 0...all_paths.length
      if all_paths[i].length < shortest.length
        shortest = all_paths[i]
      else
        next
      end
    end
    print "\nShortest path takes #{shortest.length - 1} moves: #{shortest}\n"
    return shortest
  end

  # Fill the queue with the next set of children from a node
  def fill_queue_with_children(node, previous_parent, queue)
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

  # Check to see if any possible moves of the start square include the end square
  def check_one_edge_path(start, ending, hold_original_children)
    @start.children.each do |element|
      if element == ending
        print "\nShortest path takes 1 move (you can jump straight to the end square!):\n#{[start.data, ending]}\n"
        return 1
      end

      hold_original_children << element
    end
  end

  # fill all paths array with latest, shortest child path
  def fill_all_paths(node, location, ending, all_paths, start)
    node.previously_visited << node.data
    node.previously_visited << ending
    node.previously_visited.unshift(start) unless node.previously_visited[0] == start
    all_paths << node.previously_visited
  end

  # remove the last element of all_paths array to handle a duplication issue.
  def remove_uneeded_final_path(hold_original_children, all_paths)
    if hold_original_children.empty?
      puts "\n"
      all_paths.delete_at(-1)
      get_shortest_path(all_paths)
      return 1
    end
  end

  # Return from method immediately if one or both of the arguments a user passes to the knight_moves
  # method is not a location on the board.
  def handle_off_board_args(start, ending)
    if start[0].negative? || start[0] > 7 || start[1].negative? || start[1] > 7 ||
      ending[0].negative? || ending [0] > 7 || ending[1].negative? || ending [1] > 7
     puts "\nOne or both of your knight start and end arguments is not a location on the board."
     return 1
   end
  end
end
