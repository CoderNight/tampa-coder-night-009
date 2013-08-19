class CommandRight
  attr_accessor :angle_change

  def initialize(angle_change)
    self.angle_change = angle_change || 0
  end

  def perform(turtle)
    turtle.rotate(angle_change)
  end
end
