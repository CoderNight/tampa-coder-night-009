#!/usr/bin/env ruby

require 'optparse'

require_relative 'lib/canvas_renderer'
require_relative 'lib/command_parser'
require_relative 'lib/turtle'

class LOGORunner
  def evaluate(input)
    input_lines = input.split("\n")

    canvas_size = input_lines[0].to_i
    canvas_center = canvas_size / 2
    turtle = Turtle.new(OpenStruct.new(:x => canvas_center, :y => canvas_center))

    logo_commands_text = input_lines[2..-1].join("\n")
    logo_commands = CommandParser.new.parse(logo_commands_text)
    turtle.perform_commands(logo_commands)

    CanvasRenderer.new.render(canvas_size, turtle.visited_points)
  end
end


if __FILE__==$0
  optparse = OptionParser.new do |opts|
    opts.banner = "Usage #{$0} source.logo"
  end

  if ARGV.empty?
    puts optparse
  else
    input_string = File.open(ARGV[0]).read
    puts LOGORunner.new.evaluate(input_string)
  end
end
