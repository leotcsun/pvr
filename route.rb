class Route
  attr_accessor :dest, :path_cost, :path

  def initialize(dest, path_cost, path)
    self.dest = dest
    self.path_cost = path_cost
    self.path = path
  end
end