require "reader.rb"

class Node
  attr_accessor :name, :graph, :neibours

  def initialize(name)
    @name = name
  end

  def read_edge_file(file_name="edge")
    @graph = Reader.read_edge_file(file_name)
  end

  def get_neibours
    @neibours = @graph[@name]
  end
end