# frozen_string_literal: true

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
