module Writer

  def Writer.write_table_file(node_id, routes)
    file_name = "table.#{node_id}"

    File.open(file_name, "w+") do |file|
      routes.each do |route|
        file.puts route
      end
    end
  end

end