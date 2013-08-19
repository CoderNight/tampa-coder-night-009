require "spec_helper"
require "turtle"

describe Turtle do
  context "#new" do
    it "should initialize a board" do
      Turtle.new(3).board.should == %w(. . .
                                       . X .
                                       . . .)
    end
  end
  context "#right" do
    it "should turn right" do
      Turtle.new(3).right(45).angle.should == 360-45
    end
  end
  context "#left" do
    it "should turn left" do
      Turtle.new(3).left(45).angle.should == 45
    end
  end
  context "#forward" do
    it "should move forward with angle 0" do
      Turtle.new(5).left(0).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . X . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should move forward with angle 45" do
      Turtle.new(5).left(45).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . X . . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should move forward with angle 90" do
      Turtle.new(5).left(90).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . X X . .
                         . . . . .
                         . . . . .))
    end
    it "should move forward with angle 135" do
      Turtle.new(5).left(135).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . X . . .
                         . . . . .))
    end
    it "should move forward with angle 180" do
      Turtle.new(5).left(180).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . . X . .
                         . . . . .))
    end
    it "should move forward with angle 225" do
      Turtle.new(5).left(225).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . . . X .
                         . . . . .))
    end
    it "should move forward with angle 270" do
      Turtle.new(5).left(270).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X X .
                         . . . . .
                         . . . . .))
    end
    it "should move forward with angle 315" do
      Turtle.new(5).left(315).forward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . X .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should move forward a number of steps" do
      Turtle.new(5).forward(2).should ==
        Turtle.new(5, %w(. . X . .
                         . . X . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
  end
  context "#backward" do
    it "should move backward with angle 0" do
      Turtle.new(5).left(0).backward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . . X . .
                         . . . . .))
    end
    it "should move backward with angle 45" do
      Turtle.new(5).left(45).backward(1).should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . . . X .
                         . . . . .))
    end
  end
  context "#command" do
    it "should handle FD" do
      Turtle.new(3).command("FD 1").should ==
        Turtle.new(3, %w(. X .
                         . X .
                         . . .))
    end
    it "should handle multiple commands" do
      Turtle.new(5).command("FD 1 FD 1").should ==
        Turtle.new(5, %w(. . X . .
                         . . X . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should handle LT" do
      Turtle.new(5).command("LT 45 FD 1").should ==
        Turtle.new(5, %w(. . . . .
                         . X . . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should handle RT" do
      Turtle.new(5).command("RT 45 FD 1").should ==
        Turtle.new(5, %w(. . . . .
                         . . . X .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
    it "should handle BK" do
      Turtle.new(5).command("BK 1").should ==
        Turtle.new(5, %w(. . . . .
                         . . . . .
                         . . X . .
                         . . X . .
                         . . . . .))
    end
    it "should handle REPEAT" do
      Turtle.new(5).command("REPEAT 2 [ FD 1 LT 90 ]").should ==
        Turtle.new(5, %w(. . . . .
                         . X X . .
                         . . X . .
                         . . . . .
                         . . . . .))
    end
  end
end
