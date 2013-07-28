module Reader

  def Reader.read_edge_file(file_name="edges")
    graph = Hash.new

    begin
      File.read(file_name).each_line do |line|
        next if line.lstrip.rstrip.empty?

        line  = line.split(" ")
        node1 = line[0]
        node2 = line[1]
        cost  = line[2]

        graph[node1] ||= Hash.new
        graph[node1][node2] = cost.to_i

        graph[node2] ||= Hash.new
        graph[node2][node1] = cost.to_i
      end
    rescue
      puts "Error Reading Edge File"
      exit(-1)
    end

    return graph
  end

  def Reader.read_table_file(node_id)
    file_name = "table.#{node_id}"
    routes = Hash.new

    begin
      File.read(file_name).each_line do |line|

        line      = line.split(" ")
        dest      = line[0]
        path_cost = line[1].to_i
        path      = line.slice(2, line.size)

        route = Route.new(dest, path_cost, path)
        routes[dest] = route
      end
    ensure
      return routes
    end
  end
end