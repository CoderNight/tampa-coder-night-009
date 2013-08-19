require_relative '../../lib/command_backward'
require_relative 'command_shared_spec'

describe "The Backward Command" do
  let (:distance) { :distance }

  subject { CommandBackward.new(distance) }

  it_behaves_like "a command"
  it { should respond_to :distance }

  it "can be instantated with a distance" do
    CommandBackward.new(distance).distance.should == distance
  end

  it "defaults to distance 0" do
    CommandBackward.new(nil).distance.should == 0
  end

  it "moves the turtle backward distance times" do
    distance = 11
    turtle = double("turtle")
    turtle.should_receive(:backward).exactly(distance).times

    CommandBackward.new(distance).perform(turtle)
  end
end
