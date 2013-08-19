#!/usr/bin/env ruby
# encoding: utf-8

require_relative "lib/turtle"

turtle = Turtle.new(ARGF.gets.to_i)
ARGF.each do |line|
  turtle.command(line)
end
puts turtle
