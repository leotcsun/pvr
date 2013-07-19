require "reader.rb"
require "writer.rb"

class Node
  attr_accessor :name, :graph, :neibours, :routes, :neibour_routes

  def initialize(name)
    @name = name
  end

  def read_edge_file(file_name="edges")
    @graph = Reader.read_edge_file(file_name)
    @neibours = @graph[@name].keys
  end

  def read_neibours_table_files
    @neibour_routes = Hash.new

    @neibours.each do |neibour|
      @neibour_routes[neibour] = Reader.read_table_file(neibour)
    end
  end

  def compute_routes
    @routes = Hash.new

    @neibours.each do |neibour|
      cost_to_neibour = @graph[@name][neibour]
      @routes[neibour] = Route.new(neibour, cost_to_neibour, [])
    end
  end

  def write_table_file
    routes_strings = []

    @routes.each do |neibour, route|
      path = ""
      route.path.each { |n| path = path + "#{n} "}

      routes_strings << "#{route.dest} #{route.path_cost} #{path.rstrip}"
    end

    Writer.write_table_file(@name, routes_strings)
  end

end