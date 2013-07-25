require "node.rb"

if ARGV.size != 1
  puts "Wrong number of arguments"
  puts "Usage: pvr node_id"
  exit
end

node = Node.new(ARGV[0])
node.read_edge_file
node.read_neighbours_table_files
node.compute_routes
node.write_table_file