require "./spec_helper"

module Celestine::Test
  BLANK_SVG = %Q[<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"><defs></defs></svg>]
end

describe Celestine do
  it "should generate a blank SVG document" do
    (Celestine.draw { |ctx| }).should eq(Celestine::Test::BLANK_SVG)
  end
end
