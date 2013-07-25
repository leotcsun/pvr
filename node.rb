require "reader.rb"
require "writer.rb"
require "route.rb"

class Node
  attr_accessor :name, :graph, :neighbours, :routes, :neighbour_routes

  def initialize(name)
    @name = name
  end

  def read_edge_file(file_name="edges")
    @graph = Reader.read_edge_file(file_name)
    @neighbours = @graph[@name]

    if @neighbours.nil?
      puts "Calling pvr on a node that does not exist in the edge file. Exiting..."
      exit(-1)
    end
  end

  def read_neighbours_table_files
    @neighbour_routes = Hash.new

    @neighbours.each_pair do |neighbour, _|
      @neighbour_routes[neighbour] = Reader.read_table_file(neighbour)
    end
  end

  def compute_routes
    @routes = Hash.new

    @neighbours.each_pair do |neighbour, _|
      cost_to_neighbour = @graph[@name][neighbour]
      @routes[neighbour] ||= Route.new(neighbour, cost_to_neighbour, [])
    end

    @neighbours.each_pair do |neighbour, _|
      @neighbour_routes[neighbour].values.each do |r|
        next if r.dest == @name
        relax(neighbour, r)
      end
    end
  end

  def relax(neighbour, route)
    dest = route.dest
    neighbour_cost_to_dest = route.path_cost
    cost_to_neighbour = @neighbours[neighbour]

    if @routes[dest].nil? ||
        (neighbour_cost_to_dest + cost_to_neighbour) < @routes[dest].path_cost

      cost = neighbour_cost_to_dest + cost_to_neighbour
      path = [neighbour] + route.path

      @routes[dest] = Route.new(dest, cost, path)
    end
  end

  def write_table_file
    routes_to_writes = []
    sorted_routes = @routes.sort_by { |r| r[1].dest }

    sorted_routes.each do |neighbour, route|
      path = route.path.map { |p| "#{p} "}.join.strip

      routes_to_writes << "#{route.dest} #{route.path_cost} #{path.rstrip}"
    end

    Writer.write_table_file(@name, routes_to_writes)
  end
end