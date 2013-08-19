require_relative '../../logo_runner.rb'

describe "Turtle Tracks (Integration)" do
  it "works on a simple program" do
    input = \
"11\n" \
"\n" \
"RT 90\n" \
"FD 5\n" \
"RT 135\n" \
"FD 5\n"

    expected_output = \
". . . . . . . . . . .\n" \
". . . . . . . . . . .\n" \
". . . . . . . . . . .\n" \
". . . . . . . . . . .\n" \
". . . . . . . . . . .\n" \
". . . . . X X X X X X\n" \
". . . . . . . . . X .\n" \
". . . . . . . . X . .\n" \
". . . . . . . X . . .\n" \
". . . . . . X . . . .\n" \
". . . . . X . . . . ."

    LOGORunner.new.evaluate(input).should == expected_output
  end
end
