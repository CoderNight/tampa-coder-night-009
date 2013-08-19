require 'ostruct'

class Turtle
  attr_reader :point, :orientation, :visited_points

  def initialize(point)
    @orientation = 0
    @point = point
    @visited_points = [point]
  end

  def rotate(degrees)
    @orientation = (@orientation + degrees) % 360
  end

  def forward
    move_one_unit_at_orientation(orientation)
  end

  def backward
    move_one_unit_at_orientation((orientation - 180) % 360)
  end

  def perform_commands(commands)
    commands.each do |command|
      command.perform(self)
    end
  end

private
  def create_point(x, y)
    OpenStruct.new(:x => x, :y => y)
  end

  def move_one_unit_at_orientation(orientation)
    offset_x, offset_y = offset(orientation)
    @point = create_point(point.x + offset_x, point.y + offset_y)
    @visited_points << point
  end

  def radians(degrees)
    degrees * Math::PI / 180
  end

  def offset(degrees)
    [Math.sin(radians(degrees)), Math.cos(radians(degrees))].map { |vector| round(vector) }
  end

  def round(vector)
    fudge_factor = 0.01 # fudge for precision issues
    if(vector > fudge_factor)
      vector.ceil
    elsif vector < -1 * fudge_factor
      vector.floor
    else
      0
    end
  end
end
