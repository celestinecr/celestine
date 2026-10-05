require "./spec_helper"

describe Celestine::Text do
  it "should render text element with content and font properties" do
    svg = Celestine.draw do |ctx|
      ctx.text do |t|
        t.x = 20
        t.y = 35
        t.text = "Hello Celestine"
        t.font_family = "Verdana"
        t.font_size = 18
        t.font_size_units = "px"
        t.font_weight = "bold"
        t.font_style = "italic"
        t.dominant_baseline = "middle"
        t.fill = "navy"
      end
    end

    doc = Celestine::Test.parse(svg)
    text_node = Celestine::Test.find_node(doc, "text").not_nil!
    text_node.inner_text.should eq("Hello Celestine")
    Celestine::Test.attr(text_node, "x").should eq("20")
    Celestine::Test.attr(text_node, "y").should eq("35")
    Celestine::Test.attr(text_node, "font-family").should eq("Verdana")
    Celestine::Test.attr(text_node, "font-size").should eq("18px")
    Celestine::Test.attr(text_node, "font-weight").should eq("bold")
    Celestine::Test.attr(text_node, "font-style").should eq("italic")
    Celestine::Test.attr(text_node, "dominant-baseline").should eq("middle")
    Celestine::Test.attr(text_node, "fill").should eq("navy")
  end

  it "should support dx, dy, and glyph rotation" do
    svg = Celestine.draw do |ctx|
      ctx.text do |t|
        t.dx = 5
        t.dy = -2
        t.rotate = [0.0, 10.0, 20.0]
        t.text = "ABC"
      end
    end

    doc = Celestine::Test.parse(svg)
    text_node = Celestine::Test.find_node(doc, "text").not_nil!
    Celestine::Test.attr(text_node, "dx").should eq("5")
    Celestine::Test.attr(text_node, "dy").should eq("-2")
    Celestine::Test.attr(text_node, "rotate").should eq("0.0 10.0 20.0")
  end
end
