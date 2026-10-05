require "./spec_helper"

describe Celestine::Gradient::Linear do
  it "should add a linear gradient element via DSL" do
    svg = Celestine.draw do |ctx|
      ctx.linear_gradient do |g|
        g.id = "my-linear"
        g.x1 = 0
        g.y1 = 0
        g.x2 = 1
        g.y2 = 1
      end
    end

    doc = Celestine::Test.parse(svg)
    grad = Celestine::Test.find_node(doc, "lineargradient").not_nil!
    Celestine::Test.attr(grad, "id").should eq("my-linear")
    Celestine::Test.attr(grad, "x1").should eq("0")
    Celestine::Test.attr(grad, "x2").should eq("1")
  end

  it "should add stops via block" do
    svg = Celestine.draw do |ctx|
      ctx.linear_gradient do |g|
        g.stop do |s|
          s.offset = 0.0
          s.color = "red"
        end
        g.stop do |s|
          s.offset = 1.0
          s.color = "blue"
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("lineargradient stop").size.should eq(2)
  end

  it "should add stops via parameter method" do
    svg = Celestine.draw do |ctx|
      ctx.linear_gradient do |g|
        g.stop(0.0, "red", 1.0)
        g.stop(1.0, "blue", 0.5)
      end
    end

    doc = Celestine::Test.parse(svg)
    stops = doc.css("lineargradient stop")
    stops.size.should eq(2)
    Celestine::Test.attr(stops[0], "offset").should eq("0.0")
    Celestine::Test.attr(stops[0], "stop-color").should eq("red")
    Celestine::Test.attr(stops[0], "stop-opacity").should eq("1.0")
  end

  it "should reference linear gradient via fill" do
    svg = Celestine.draw do |ctx|
      lg = ctx.linear_gradient do |g|
        g.id = "lin-grad"
      end

      ctx.rectangle do |r|
        r.set_fill lg
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(rect, "fill").should eq("url(#lin-grad)")
  end

  it "should reference linear gradient via stroke" do
    svg = Celestine.draw do |ctx|
      lg = ctx.linear_gradient do |g|
        g.id = "lin-grad-stroke"
      end

      ctx.rectangle do |r|
        r.set_stroke lg
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(rect, "stroke").should eq("url(#lin-grad-stroke)")
  end

  it "should support gradientTransform" do
    svg = Celestine.draw do |ctx|
      ctx.linear_gradient do |g|
        g.gradient_transform do |t|
          t.rotate(45)
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    grad = Celestine::Test.find_node(doc, "lineargradient").not_nil!
    Celestine::Test.attr(grad, "gradienttransform").should eq("rotate(45) ")
  end
end

describe Celestine::Gradient::Radial do
  it "should add a radial gradient element via DSL" do
    svg = Celestine.draw do |ctx|
      ctx.radial_gradient do |g|
        g.id = "my-radial"
        g.start_x = 0.5
        g.start_y = 0.5
        g.radius = 0.5
      end
    end

    doc = Celestine::Test.parse(svg)
    grad = Celestine::Test.find_node(doc, "radialgradient").not_nil!
    Celestine::Test.attr(grad, "id").should eq("my-radial")
    Celestine::Test.attr(grad, "fx").should eq("0.5")
    Celestine::Test.attr(grad, "fy").should eq("0.5")
    Celestine::Test.attr(grad, "r").should eq("0.5")
  end

  it "should add stops via parameter method in radial gradient" do
    svg = Celestine.draw do |ctx|
      ctx.radial_gradient do |g|
        g.stop(0.0, "white")
        g.stop(1.0, "black")
      end
    end

    doc = Celestine::Test.parse(svg)
    stops = doc.css("radialgradient stop")
    stops.size.should eq(2)
  end

  it "should reference radial gradient via fill and stroke" do
    svg = Celestine.draw do |ctx|
      rg = ctx.radial_gradient do |g|
        g.id = "rad-grad"
      end

      ctx.circle do |c|
        c.set_fill rg
        c.set_stroke rg
      end
    end

    doc = Celestine::Test.parse(svg)
    circle = Celestine::Test.find_node(doc, "circle").not_nil!
    Celestine::Test.attr(circle, "fill").should eq("url(#rad-grad)")
    Celestine::Test.attr(circle, "stroke").should eq("url(#rad-grad)")
  end
end
