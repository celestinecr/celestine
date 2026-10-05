require "./spec_helper"

describe Celestine::Rectangle do
  make_number_attribute_test(Celestine::Rectangle, "rx", "radius_x", units: true)
  make_number_attribute_test(Celestine::Rectangle, "ry", "radius_y", units: true)

  it "should render rectangle with geometry, corners, and style" do
    svg = Celestine.draw do |ctx|
      ctx.rectangle do |r|
        r.x = 10
        r.y = 20
        r.width = 100
        r.height = 50
        r.radius_x = 5
        r.radius_y = 8
        r.fill = "blue"
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(rect, "x").should eq("10")
    Celestine::Test.attr(rect, "y").should eq("20")
    Celestine::Test.attr(rect, "width").should eq("100")
    Celestine::Test.attr(rect, "height").should eq("50")
    Celestine::Test.attr(rect, "rx").should eq("5")
    Celestine::Test.attr(rect, "ry").should eq("8")
    Celestine::Test.attr(rect, "fill").should eq("blue")
  end
end
