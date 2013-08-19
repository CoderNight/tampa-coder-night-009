require 'command_forward'
require 'command_backward'
require 'command_left'
require 'command_right'

class CommandParser
  def parse(input)
    tokens = input.split(" ")
    result = parse_rec(tokens, [])
    result.flatten
  end

private
  def parse_rec(tokens, current_result)
    if tokens.nil? || tokens.count <= 0
      return current_result
    end

    this_result, remaining_args = self.send(tokens[0], tokens[1..-1])
    parse_rec(remaining_args, current_result + [ this_result ])
  end

  def FD(args)
    [CommandForward.new(args[0].to_i), args[1..-1]]
  end

  def BK(args)
    [CommandBackward.new(args[0].to_i), args[1..-1]]
  end

  def RT(args)
    [CommandRight.new(args[0].to_i), args[1..-1]]
  end

  def LT(args)
    [CommandLeft.new(args[0].to_i), args[1..-1]]
  end

  def REPEAT(args)
    bracket_start, bracket_end = find_inner_bracket_bounds(args)
    command_to_repeat = args[bracket_start...bracket_end].join(" ")
    commands = args[0].to_i.times.map do
      parse(command_to_repeat)
    end

    remaining_args = args[(bracket_end + 1)..-1]
    [commands, remaining_args]
  end

  def find_inner_bracket_bounds(args)
    bracket_start = bracket_end = -1
    bracket_level = 0;

    args.each_with_index do |arg, index|
      if arg == "["
        bracket_level += 1
        bracket_start = index if bracket_start < 0
      elsif arg == "]"
        bracket_level -= 1
      end

      if bracket_level == 0 && bracket_start >= 0
        bracket_end = index
        break
      end
    end

    [bracket_start + 1, bracket_end]
  end
end
