class CommandLeft
  attr_accessor :angle_change

  def initialize(angle_change)
    self.angle_change = angle_change || 0
  end

  def perform(turtle)
    turtle.rotate(-1 * angle_change)
  end
end
