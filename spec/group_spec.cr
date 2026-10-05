require "./spec_helper"

describe Celestine::Group do
  it "should generate a group with child drawables" do
    svg = Celestine.draw do |ctx|
      ctx.group do |g|
        g.fill = "none"
        g.stroke = "green"
        g.circle do |c|
          c.x = 20
          c.y = 20
          c.radius = 10
        end
        g.rectangle do |r|
          r.x = 40
          r.y = 20
          r.width = 20
          r.height = 20
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    g_node = Celestine::Test.find_node(doc, "g").not_nil!
    Celestine::Test.attr(g_node, "fill").should eq("none")
    Celestine::Test.attr(g_node, "stroke").should eq("green")
    doc.css("g circle").size.should eq(1)
    doc.css("g rect").size.should eq(1)
  end

  it "should support transforms on groups" do
    svg = Celestine.draw do |ctx|
      ctx.group do |g|
        g.transform do |t|
          t.translate(50, 50)
          t.rotate(45)
          t.scale(2)
        end
        g.circle { |c| c.radius = 5 }
      end
    end

    doc = Celestine::Test.parse(svg)
    g_node = Celestine::Test.find_node(doc, "g").not_nil!
    Celestine::Test.attr(g_node, "transform").should eq("translate(50,50) rotate(45) scale(2) ")
  end
end
