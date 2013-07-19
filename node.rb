require "reader.rb"
require "writer.rb"

class Node
  attr_accessor :name, :graph, :neibours, :routes, :neibour_routes

  def initialize(name)
    @name = name
  end

  def read_edge_file(file_name="edges")
    @graph = Reader.read_edge_file(file_name)
    @neibours = @graph[@name]
  end

  def read_neibours_table_files
    @neibour_routes = Hash.new

    @neibours.each_pair do |neibour, _|
      @neibour_routes[neibour] = Reader.read_table_file(neibour)
    end
  end

  def compute_routes
    @routes = Hash.new

    @neibours.each_pair do |neibour, _|
      cost_to_neibour = @graph[@name][neibour]
      @routes[neibour] = Route.new(neibour, cost_to_neibour, [])

      @neibour_routes[neibour].values.each do |r|
        next if r.path.include?(@name) || r.dest == @name
        relax(neibour, r)
      end
    end
  end

  def relax(neibour, route)
    dest = route.dest
    neibour_cost_to_dest = route.path_cost
    cost_to_neibour = @neibours[neibour]

    if @routes[dest].nil? ||
        neibour_cost_to_dest + cost_to_neibour < @routes[dest].path_cost

      cost = neibour_cost_to_dest + cost_to_neibour
      path = [neibour] + route.path

      @routes[dest] = Route.new(dest, cost, path)
    end
  end

  def write_table_file
    routes_to_writes = []

    @routes.each do |neibour, route|
      path = ""
      route.path.each { |n| path = path + "#{n} "}

      routes_to_writes << "#{route.dest} #{route.path_cost} #{path.rstrip}"
    end

    Writer.write_table_file(@name, routes_to_writes)
  end

end