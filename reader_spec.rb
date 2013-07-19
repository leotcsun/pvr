require "spec_helper"

describe "Reader" do

  it "reads edge files" do
    graph = Reader.read_edge_file("edges.sample")

    graph["1"]["3"].should == 1
    graph["1"]["2"].should == 4
    graph["3"]["5"].should == 2
    graph["2"]["5"].should == 3
    graph["2"]["4"].should == 5
    graph["4"]["7"].should == 2
    graph["5"]["6"].should == 1
    graph["6"]["7"].should == 4
    graph["6"]["4"].should == 2
    graph["5"]["7"].should == 6

    graph["3"]["1"].should == 1
    graph["2"]["1"].should == 4
    graph["5"]["3"].should == 2
    graph["5"]["2"].should == 3
    graph["4"]["2"].should == 5
    graph["7"]["4"].should == 2
    graph["6"]["5"].should == 1
    graph["7"]["6"].should == 4
    graph["4"]["6"].should == 2
    graph["7"]["5"].should == 6
  end

  it "reads table files" do
    routes = Reader.read_table_file("sample")

    dest_E = routes["5"]
    dest_E.dest.should == "5"
    dest_E.path_cost.should == 6
    dest_E.path == []

    dest_B = routes["2"]
    dest_B.dest.should == "2"
    dest_B.path_cost.should == 8
    dest_B.path == ["6", "5"]
  end
end