require_relative '../../lib/command_right'
require_relative 'command_shared_spec'

describe "The Right Command" do
  let (:angle_change) { :angle_change }

  subject { CommandRight.new(angle_change) }

  it_behaves_like "a command"
  it { should respond_to :angle_change }

  it "can be instantated with an angle_change" do
    CommandRight.new(angle_change).angle_change.should == angle_change
  end

  it "defaults to angle_change 0" do
    CommandRight.new(nil).angle_change.should == 0
  end

  it "rotates the turtle angle_change degrees" do
    angle_change = 42
    turtle = double("turtle")
    turtle.should_receive(:rotate).with(angle_change)

    CommandRight.new(angle_change).perform(turtle)
  end
end
