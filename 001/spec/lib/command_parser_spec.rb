require_relative '../../lib/command_parser'

describe "The Command Parser" do
  it "exists" do
    CommandParser.new.should_not be_nil
  end

  describe "Parsing commands" do
    let (:parser) { CommandParser.new }

    [{ :command => "FD 10", :distance => 10, :class => CommandForward },
     { :command => "BK 11", :distance => 11, :class => CommandBackward }]
    .each do |expectation|
      it "can parse a single movement #{expectation[:class]}" do
        command_list = parser.parse(expectation[:command])

        command_list.count.should == 1
        command_list[0].should be_a(expectation[:class])
        command_list[0].distance.should == expectation[:distance]
      end
    end

    [{ :command => "RT 45", :angle_change => 45, :class => CommandRight},
     { :command => "LT 135", :angle_change => 135, :class => CommandLeft}]
    .each do |expectation|
      it "can parse a single rotation #{expectation[:class]}" do
        command_list = parser.parse(expectation[:command])

        command_list.count.should == 1
        command_list[0].should be_a(expectation[:class])
        command_list[0].angle_change.should == expectation[:angle_change]
      end
    end

    it "can parse multiple commands" do
      input = "FD 10\nBK 11\nFD 42"

      command_list = parser.parse(input)

      command_list.count.should == 3
      command_list[0].should be_a(CommandForward)
      command_list[0].distance.should == 10
      command_list[1].should be_a(CommandBackward)
      command_list[1].distance.should == 11
      command_list[2].should be_a(CommandForward)
      command_list[2].distance.should == 42
    end

    describe "Correctly repeats with the REPEAT command" do
      it "for a single command" do
        repeat_count = 5
        distance = 12
        input = "REPEAT #{repeat_count} [ FD #{distance} ]"

        command_list = parser.parse(input)

        command_list.count.should == repeat_count
        (0...repeat_count).each do |i|
          command_list[i].should be_a(CommandForward)
          command_list[i].distance.should == distance
        end
      end

      it "for multiple commands" do
        repeat_count = 5
        distance_forward = 12
        distance_backward = 7
        input = "REPEAT #{repeat_count} [ FD #{distance_forward} BK #{distance_backward} ]"

        command_list = parser.parse(input)

        command_list.count.should == repeat_count * 2
        (0...repeat_count).each do |count|
          i = count * 2
          command_list[i].should be_a(CommandForward)
          command_list[i].distance.should == distance_forward
          command_list[i + 1].should be_a(CommandBackward)
          command_list[i + 1].distance.should == distance_backward
        end
      end
    end

    it "can parse a complex command" do
      input = "FD 0\n"\
              "BK 1\n"\
              "REPEAT 2 [ FD 3 BK 4 ]\n"\
              "FD 5\n"\
              "BK 6\n"

      command_list = parser.parse(input)

      command_list.count.should == 8
      command_list[0].should be_a(CommandForward)
      command_list[0].distance.should == 0
      command_list[1].should be_a(CommandBackward)
      command_list[1].distance.should == 1
      command_list[2].should be_a(CommandForward)
      command_list[2].distance.should == 3
      command_list[3].should be_a(CommandBackward)
      command_list[3].distance.should == 4
      command_list[4].should be_a(CommandForward)
      command_list[4].distance.should == 3
      command_list[5].should be_a(CommandBackward)
      command_list[5].distance.should == 4
      command_list[6].should be_a(CommandForward)
      command_list[6].distance.should == 5
      command_list[7].should be_a(CommandBackward)
      command_list[7].distance.should == 6
    end

    it "can parse a recursive REPEAT statement" do
      first_multiplier = 2
      second_multiplier = 3
      num_repeated_commands = 2
      repeated_forward_distance = 10
      repeated_backward_distance = 3
      non_repeated_distance = 42
      input = "REPEAT #{first_multiplier} [ REPEAT #{second_multiplier} [ REPEAT 1 [ FD #{repeated_forward_distance} ] BK #{repeated_backward_distance} ]  ]\n"\
              "BK #{non_repeated_distance}"

      command_list = parser.parse(input)

      command_list.count.should == ((first_multiplier * second_multiplier) * num_repeated_commands) + 1

      (first_multiplier * second_multiplier).times do |i|
        index = i * num_repeated_commands
        command_list[index].should be_a(CommandForward)
        command_list[index].distance.should == repeated_forward_distance
        command_list[index + 1].should be_a(CommandBackward)
        command_list[index + 1].distance.should == repeated_backward_distance
      end

      command_list.last.should be_a(CommandBackward)
      command_list.last.distance.should == non_repeated_distance
    end
  end
end
