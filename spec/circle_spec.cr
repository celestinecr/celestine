require "./spec_helper"

describe Celestine::Circle do
  make_number_attribute_test(Celestine::Circle, "r", "radius", units: true)

  it "should calculate diameter correctly" do
    c = Celestine::Circle.new
    c.radius = 15
    c.diameter.should eq(30)
  end

  it "should safely return nil for diameter if radius is not set" do
    c = Celestine::Circle.new
    c.diameter.should be_nil
  end

  it "should render circle with stroke and fill" do
    svg = Celestine.draw do |ctx|
      ctx.circle do |c|
        c.x = 50
        c.y = 50
        c.radius = 25
        c.fill = "#FF0000"
        c.stroke = "#000000"
        c.stroke_width = 2
      end
    end

    doc = Celestine::Test.parse(svg)
    circle = Celestine::Test.find_node(doc, "circle").not_nil!
    Celestine::Test.attr(circle, "cx").should eq("50")
    Celestine::Test.attr(circle, "cy").should eq("50")
    Celestine::Test.attr(circle, "r").should eq("25")
    Celestine::Test.attr(circle, "fill").should eq("#FF0000")
    Celestine::Test.attr(circle, "stroke").should eq("#000000")
    Celestine::Test.attr(circle, "stroke-width").should eq("2")
  end
end
