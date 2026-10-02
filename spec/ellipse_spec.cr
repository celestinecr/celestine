require "./spec_helper"

describe Celestine::Ellipse do
  make_number_attribute_test(Celestine::Ellipse, "rx", "radius_x", units: true)
  make_number_attribute_test(Celestine::Ellipse, "ry", "radius_y", units: true)

  it "should render ellipse with cx, cy, rx, ry" do
    svg = Celestine.draw do |ctx|
      ctx.ellipse do |e|
        e.x = 100
        e.y = 80
        e.radius_x = 40
        e.radius_y = 20
        e.fill = "green"
      end
    end

    doc = Celestine::Test.parse(svg)
    ellipse = Celestine::Test.find_node(doc, "ellipse").not_nil!
    Celestine::Test.attr(ellipse, "cx").should eq("100")
    Celestine::Test.attr(ellipse, "cy").should eq("80")
    Celestine::Test.attr(ellipse, "rx").should eq("40")
    Celestine::Test.attr(ellipse, "ry").should eq("20")
    Celestine::Test.attr(ellipse, "fill").should eq("green")
  end
end
