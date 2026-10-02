require "./spec_helper"

describe Celestine::Polygon do
  it "should render polygon with raw points string" do
    svg = Celestine.draw do |ctx|
      ctx.polygon do |p|
        p.points = "0,100 50,25 50,75 100,0"
        p.fill = "lime"
        p.stroke = "purple"
        p.stroke_width = 1
      end
    end

    doc = Celestine::Test.parse(svg)
    poly = Celestine::Test.find_node(doc, "polygon").not_nil!
    Celestine::Test.attr(poly, "points").should eq("0,100 50,25 50,75 100,0")
    Celestine::Test.attr(poly, "fill").should eq("lime")
    Celestine::Test.attr(poly, "stroke").should eq("purple")
    Celestine::Test.attr(poly, "stroke-width").should eq("1")
  end

  it "should render polygon with points added via coordinate tuples" do
    svg = Celestine.draw do |ctx|
      ctx.polygon do |p|
        p.add_point(0, 0)
        p.add_point(100, 50)
        p.add_point(50, 100)
      end
    end

    doc = Celestine::Test.parse(svg)
    poly = Celestine::Test.find_node(doc, "polygon").not_nil!
    Celestine::Test.attr(poly, "points").should eq("0,0 100,50 50,100")
  end

  it "should render polygon with points added via Point/FPoint" do
    svg = Celestine.draw do |ctx|
      ctx.polygon do |p|
        p.add_point(Celestine::Point.new(10, 20))
        p.add_point(Celestine::FPoint.new(30.5, 40.5))
      end
    end

    doc = Celestine::Test.parse(svg)
    poly = Celestine::Test.find_node(doc, "polygon").not_nil!
    Celestine::Test.attr(poly, "points").should eq("10,20 30.5,40.5")
  end
end
