require 'rspec'
require_relative '../../lib/canvas_renderer'

describe "The Canvas Renderer" do
  it "can be instantiated" do
    CanvasRenderer.new
  end

  describe "rendering the canvas" do
    let (:renderer) { CanvasRenderer.new }

    describe "for an empty canvas" do
      let (:commands) { [] }
      it "can render an empty 1x1 canvas" do
        expected_output = "."

        renderer.render(1, commands).should == expected_output
      end

      it "can render an empty 2x2 canvas" do
        expected_output = ". .\n. ."

        renderer.render(2, commands).should == expected_output
      end
    end

    it "with items on the canvas" do
      commands = [double(:x => 0, :y => 0),
                  double(:x => 1, :y => 1)]

      expected_output = ". X\nX ."
      renderer.render(2, commands).should == expected_output
    end
  end
end
