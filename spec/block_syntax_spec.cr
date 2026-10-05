require "./spec_helper"

describe "Block syntax and container ergonomics" do
  it "allows DSL blocks without requiring the block to return the element" do
    svg = Celestine.draw do |ctx|
      ctx.rectangle do |r|
        r.x = 20
        r.y = 30
        r.width = 100
        r.height = 50
        # No explicit `r` at the end
        1 + 1
      end

      ctx.circle do |c|
        c.x = 50
        c.y = 50
        c.radius = 25
        "some random string"
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    circle = Celestine::Test.find_node(doc, "circle").not_nil!
    Celestine::Test.attr(rect, "x").should eq("20")
    Celestine::Test.attr(rect, "y").should eq("30")
    Celestine::Test.attr(circle, "r").should eq("25")
  end

  it "renders multiple transform operations in sequence" do
    svg = Celestine.draw do |ctx|
      ctx.group do |g|
        g.transform do |t|
          t.translate(10, 20)
          t.rotate(45, 50, 50)
          t.scale(2, 2)
          t.skew_x(15)
          t.skew_y(5)
        end
        g.circle { |c| c.radius = 10 }
      end
    end

    doc = Celestine::Test.parse(svg)
    g_node = Celestine::Test.find_node(doc, "g").not_nil!
    transform_val = Celestine::Test.attr(g_node, "transform").not_nil!
    transform_val.should contain("translate(10,20)")
    transform_val.should contain("rotate(45 50 50)")
    transform_val.should contain("scale(2,2)")
    transform_val.should contain("skewX(15)")
    transform_val.should contain("skewY(5)")
  end

  it "supports deeply nested containers and hierarchy" do
    svg = Celestine.draw do |ctx|
      ctx.group do |g1|
        g1.id = "level-1"
        g1.group do |g2|
          g2.id = "level-2"
          g2.anchor do |a|
            a.href = "https://celestine.dev"
            a.rectangle do |r|
              r.width = 50
              r.height = 50
            end
          end
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    g1 = Celestine::Test.find_node(doc, "#level-1").not_nil!
    g2 = Celestine::Test.find_node(doc, "#level-2").not_nil!
    a = Celestine::Test.find_node(doc, "a").not_nil!
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(a, "href").should eq("https://celestine.dev")
    Celestine::Test.attr(rect, "width").should eq("50")
  end

  it "supports radial gradients with focal points and radius" do
    svg = Celestine.draw do |ctx|
      ctx.radial_gradient do |rg|
        rg.id = "glow-radial"
        rg.cx = 50
        rg.cx_units = "%"
        rg.cy = 50
        rg.cy_units = "%"
        rg.r = 50
        rg.r_units = "%"
        rg.fx = 40
        rg.fx_units = "%"
        rg.fy = 40
        rg.fy_units = "%"
        rg.stop(0, color: "white", opacity: 1.0)
        rg.stop(100, color: "black", opacity: 0.0)
      end
    end

    doc = Celestine::Test.parse(svg)
    rg = Celestine::Test.find_node(doc, "radialgradient").not_nil!
    Celestine::Test.attr(rg, "id").should eq("glow-radial")
    Celestine::Test.attr(rg, "cx").should eq("50%")
    Celestine::Test.attr(rg, "cy").should eq("50%")
    Celestine::Test.attr(rg, "r").should eq("50%")
    Celestine::Test.attr(rg, "fx").should eq("40%")
    Celestine::Test.attr(rg, "fy").should eq("40%")
    doc.css("radialgradient stop").size.should eq(2)
  end
end
