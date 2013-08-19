class CommandForward
  attr_accessor :distance

  def initialize(distance)
    self.distance = distance || 0
  end

  def perform(turtle)
    distance.times { turtle.forward }
  end
end
