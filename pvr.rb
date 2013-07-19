require "node.rb"

node = Node.new(ARGV[0])

node.read_edge_file
node.read_neibours_table_files
node.compute_routes
node.write_table_file