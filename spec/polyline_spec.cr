require "./spec_helper"

describe Celestine::Polyline do
  it "should render polyline with raw points string" do
    svg = Celestine.draw do |ctx|
      ctx.polyline do |p|
        p.points = "20,20 40,25 60,40 80,120 120,140 200,180"
        p.fill = "none"
        p.stroke = "black"
        p.stroke_width = 3
      end
    end

    doc = Celestine::Test.parse(svg)
    poly = Celestine::Test.find_node(doc, "polyline").not_nil!
    Celestine::Test.attr(poly, "points").should eq("20,20 40,25 60,40 80,120 120,140 200,180")
    Celestine::Test.attr(poly, "fill").should eq("none")
    Celestine::Test.attr(poly, "stroke").should eq("black")
    Celestine::Test.attr(poly, "stroke-width").should eq("3")
  end

  it "should render polyline with points added via coordinate tuples" do
    svg = Celestine.draw do |ctx|
      ctx.polyline do |p|
        p.add_point(0, 0)
        p.add_point(50, 25)
      end
    end

    doc = Celestine::Test.parse(svg)
    poly = Celestine::Test.find_node(doc, "polyline").not_nil!
    Celestine::Test.attr(poly, "points").should eq("0,0 50,25")
  end
end
