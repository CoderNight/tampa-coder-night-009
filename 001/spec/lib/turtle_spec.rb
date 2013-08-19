require_relative "../../lib/turtle"

describe "The Turtle" do
  let (:initial_point) { OpenStruct.new(:x => 0, :y => 0) }
  let (:turtle) { Turtle.new(initial_point) }

  describe "initialization" do
    it "takes a point" do
      Turtle.new(initial_point).point.should == initial_point
    end

    it "defaults to 0 degrees" do
      Turtle.new(initial_point).orientation.should == 0
    end

    it "adds the start point to the list of visited points" do
      turtle = Turtle.new(initial_point)
      turtle.visited_points.count.should == 1
      turtle.visited_points[0].should == initial_point
    end
  end

  describe "rotation" do
    it "adds to the current orientation" do
      angle = 42
      turtle.rotate(angle)
      turtle.orientation.should == angle
    end

    it "adds to the current orientation (mod 360)" do
      angle = 361
      turtle.rotate(angle)
      turtle.orientation.should == (angle % 360)
    end

    it "adds to the current orientation (negative)" do
      angle = -45
      turtle.rotate(angle)
      turtle.orientation.should == angle + 360
    end
  end

  describe "movement" do
    describe "forward" do
      [ {:orientation => 0, :x => 0, :y => 1},
        {:orientation => 45, :x => 1, :y => 1},
        {:orientation => 90, :x => 1, :y => 0},
        {:orientation => 135, :x => 1, :y => -1},
        {:orientation => 180, :x => 0, :y => -1},
        {:orientation => 225, :x => -1, :y => -1},
        {:orientation => 270, :x => -1, :y => 0},
        {:orientation => 315, :x => -1, :y => 1} ]
      .each do |expectation|
        it "moves x: #{expectation[:x]} and y: #{expectation[:y]} in orientation: #{expectation[:orientation]}" do
          turtle.rotate(expectation[:orientation])
          turtle.forward

          turtle.visited_points.count.should == 2
          turtle.visited_points.last.x.should == expectation[:x]
          turtle.visited_points.last.y.should == expectation[:y]

          turtle.point.x.should == expectation[:x]
          turtle.point.y.should == expectation[:y]
        end
      end
    end

    describe "backward" do
      [ {:orientation => 0, :x => 0, :y => -1},
        {:orientation => 45, :x => -1, :y => -1},
        {:orientation => 90, :x => -1, :y => 0},
        {:orientation => 135, :x => -1, :y => 1},
        {:orientation => 180, :x => 0, :y => 1},
        {:orientation => 225, :x => 1, :y => 1},
        {:orientation => 270, :x => 1, :y => 0},
        {:orientation => 315, :x => 1, :y => -1} ]
      .each do |expectation|
        it "moves x: #{expectation[:x]} and y: #{expectation[:y]} in orientation: #{expectation[:orientation]}" do
          turtle.rotate(expectation[:orientation])
          turtle.backward

          turtle.visited_points.count.should == 2
          turtle.visited_points.last.x.should == expectation[:x]
          turtle.visited_points.last.y.should == expectation[:y]

          turtle.point.x.should == expectation[:x]
          turtle.point.y.should == expectation[:y]
        end
      end
    end
  end

  describe "Responding to commands" do
    it "executes each command in the command list on itself" do
      commands = [double("command"), double("command"), double("command")]
      commands.each do |command|
        command.should_receive(:perform).with(turtle)
      end

      turtle.perform_commands(commands)
    end
  end
end
