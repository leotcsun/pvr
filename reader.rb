module Reader

  def Reader.read_edge_file(file_name="edges")
    graph = Hash.new

    File.read(file_name).each_line do |line|
      next if line.lstrip.rstrip.empty?

      inputs = line.split(" ")
      node1  = inputs[0]
      node2  = inputs[1]
      cost   = inputs[2]

      graph[node1] ||= Hash.new
      graph[node1][node2] = cost.to_i

      graph[node2] ||= Hash.new
      graph[node2][node1] = cost.to_i
    end

    graph
  end

end