require "spec_helper.rb"


describe Node do

  it "knows its own name" do
    node = Node.new("5")
    node.name.should == "5"
  end

  it "reads graph from edge files" do
    node = Node.new("5")
    node.read_edge_file("edges.sample")
    node.graph.should_not be_nil
  end

  it "finds out its neibours form the graph" do
    node = Node.new("5")
    node.read_edge_file("edges.sample")

    neibours = node.graph["5"].keys
    neibours.should include "C"
    neibours.should include "B"
    neibours.should include "F"
    neibours.should include "G"
  end

end