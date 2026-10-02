require "./spec_helper"

describe Celestine::Line do
  make_number_attribute_test(Celestine::Line, "x1", units: true)
  make_number_attribute_test(Celestine::Line, "y1", units: true)
  make_number_attribute_test(Celestine::Line, "x2", units: true)
  make_number_attribute_test(Celestine::Line, "y2", units: true)

  it "should render line with x1, y1, x2, y2, and stroke" do
    svg = Celestine.draw do |ctx|
      ctx.line do |l|
        l.x1 = 0
        l.y1 = 10
        l.x2 = 100
        l.y2 = 200
        l.stroke = "purple"
        l.stroke_width = 3
      end
    end

    doc = Celestine::Test.parse(svg)
    line = Celestine::Test.find_node(doc, "line").not_nil!
    Celestine::Test.attr(line, "x1").should eq("0")
    Celestine::Test.attr(line, "y1").should eq("10")
    Celestine::Test.attr(line, "x2").should eq("100")
    Celestine::Test.attr(line, "y2").should eq("200")
    Celestine::Test.attr(line, "stroke").should eq("purple")
    Celestine::Test.attr(line, "stroke-width").should eq("3")
  end
end
