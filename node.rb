require "reader.rb"
require "writer.rb"
require "route.rb"

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

    # puts @neibour_routes.inspect
    # puts "@@@@@@@@@@@@@@@@@@@@@@"
  end

  def compute_routes
    @routes = Hash.new

    @neibours.each_pair do |neibour, _|
      cost_to_neibour = @graph[@name][neibour]
      @routes[neibour] ||= Route.new(neibour, cost_to_neibour, [])
    end

    @neibours.each_pair do |neibour, _|
      @neibour_routes[neibour].values.each do |r|
        next if r.path.include?(@name) || r.dest == @name
        relax(neibour, r)
      end
    end

    # puts @routes.inspect
  end

  def relax(neibour, route)
    dest = route.dest
    neibour_cost_to_dest = route.path_cost
    cost_to_neibour = @neibours[neibour]

    puts "********************************"
    puts "neibour #{neibour}, dest #{dest}"
    puts "neibour_cost_to_dest #{neibour_cost_to_dest}, neibour_path_to_dest #{route.path.inspect}, cost_to_neibour #{cost_to_neibour}"
    puts "#{@routes[dest].inspect}"

    if @routes[dest].nil? ||
        (neibour_cost_to_dest + cost_to_neibour) < @routes[dest].path_cost

      cost = neibour_cost_to_dest + cost_to_neibour
      path = [neibour] + route.path

      @routes[dest] = Route.new(dest, cost, path)

      # puts @routes[dest].inspect
      # puts "XXX"
      # puts @routes.inspect
      # puts "YYY"
    end

    # puts "ZZZ"
    puts @routes.inspect
  end

  def write_table_file
    routes_to_writes = []
    sorted_routes = @routes.sort { |a, b| a[1].dest <=> b[1].dest }

    # puts @routes.inspect
    # puts sorted_routes.inspect

    sorted_routes.each do |neibour, route|
      path = ""
      route.path.each { |n| path = path + "#{n} "}

      routes_to_writes << "#{route.dest} #{route.path_cost} #{path.rstrip}"
    end

    Writer.write_table_file(@name, routes_to_writes)
  end

end