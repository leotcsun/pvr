require "spec_helper"

describe "Reader" do

  it "reads edge files" do
    graph = Reader.read_edge_file("edges.sample")

    graph["A"]["C"].should == 1
    graph["A"]["B"].should == 4
    graph["C"]["E"].should == 2
    graph["B"]["E"].should == 3
    graph["B"]["D"].should == 5
    graph["D"]["G"].should == 2
    graph["E"]["F"].should == 1
    graph["F"]["G"].should == 4
    graph["F"]["D"].should == 2
    graph["E"]["G"].should == 6

    graph["C"]["A"].should == 1
    graph["B"]["A"].should == 4
    graph["E"]["C"].should == 2
    graph["E"]["B"].should == 3
    graph["D"]["B"].should == 5
    graph["G"]["D"].should == 2
    graph["F"]["E"].should == 1
    graph["G"]["F"].should == 4
    graph["D"]["F"].should == 2
    graph["G"]["E"].should == 6
  end

  it "reads table files" do
    routes = Reader.read_table_file("table.sample")

    dest_E = routes["E"]
    dest_E.dest.should == "E"
    dest_E.path_cost.should == 6
    dest_E.path == []

    dest_B = routes["B"]
    dest_B.dest.should == "B"
    dest_B.path_cost.should == 8
    dest_B.path == ["F", "E"]
  end
end