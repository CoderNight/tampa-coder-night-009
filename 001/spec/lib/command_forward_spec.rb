require_relative '../../lib/command_forward'
require_relative 'command_shared_spec'

describe "The Forward Command" do
  let (:distance) { :distance }

  subject { CommandForward.new(distance) }

  it_behaves_like "a command"
  it { should respond_to :distance }

  it "can be instantated with a distance" do
    CommandForward.new(distance).distance.should == distance
  end

  it "defaults to distance 0" do
    CommandForward.new(nil).distance.should == 0
  end

  it "moves the turtle forward distance times" do
    distance = 11
    turtle = double("turtle")
    turtle.should_receive(:forward).exactly(distance).times

    CommandForward.new(distance).perform(turtle)
  end
end
