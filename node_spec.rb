require "spec_helper.rb"


describe Node do

  context "7 node sample" do
    it "knows its own name" do
      node = Node.new("5")
      node.name.should == "5"
    end

    it "reads graph from edge files" do
      node = Node.new("5")
      node.read_edge_file("edges.sample")
      node.graph.should_not be_nil
    end

    it "finds out its neighbours form the graph" do
      node = Node.new("5")
      node.read_edge_file("edges.sample")

      node.neighbours.should include "3"
      node.neighbours.should include "2"
      node.neighbours.should include "6"
      node.neighbours.should include "7"
    end
  end

  context "5 node sample" do
    before(:each) do
      @node = Node.new("4")
      @node.read_edge_file("edges")
      @node.read_neighbours_table_files
    end

    it "reads table files of its neighbours" do
      @node.neighbour_routes.should_not be_nil
      @node.neighbour_routes.keys.size.should > 0
    end

    it "computes routes to its neighbours" do
      @node.compute_routes

      route_to_c = @node.routes["2"]
      route_to_c.should_not be_nil
      route_to_c.path_cost.should > 0
      route_to_c.path.should == []
    end

    # it "writes its own table file" do
    #   @node.compute_routes
    #   @node.write_table_file

    #   file = File.open("table.4")
    #   file.should_not be_nil

    #   file.close
    # end
  end

end