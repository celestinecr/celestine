require "./spec_helper"

describe Celestine do
  it "should generate a blank SVG document" do
    svg = Celestine.draw { |ctx| }
    doc = Celestine::Test.parse(svg)
    svg_node = Celestine::Test.find_node(doc, "svg")
    svg_node.should_not be_nil
    Celestine::Test.attr(svg_node.not_nil!, "xmlns").should eq("http://www.w3.org/2000/svg")
  end

  it "should support viewBox via NamedTuple" do
    svg = Celestine.draw do |ctx|
      ctx.view_box = {x: 0, y: 0, w: 100, h: 200}
    end
    doc = Celestine::Test.parse(svg)
    svg_node = Celestine::Test.find_node(doc, "svg").not_nil!
    Celestine::Test.attr(svg_node, "viewbox").should eq("0 0 100 200")
  end

  it "should support viewBox via string" do
    svg = Celestine.draw do |ctx|
      ctx.view_box = "10 20 300 400"
    end
    doc = Celestine::Test.parse(svg)
    svg_node = Celestine::Test.find_node(doc, "svg").not_nil!
    Celestine::Test.attr(svg_node, "viewbox").should eq("10 20 300 400")
  end

  it "should support viewBox via method" do
    svg = Celestine.draw do |ctx|
      ctx.view_box(5, 10, 50, 60)
    end
    doc = Celestine::Test.parse(svg)
    svg_node = Celestine::Test.find_node(doc, "svg").not_nil!
    Celestine::Test.attr(svg_node, "viewbox").should eq("5 10 50 60")
  end

  it "should set root width and height" do
    svg = Celestine.draw do |ctx|
      ctx.width = 800
      ctx.width_units = "px"
      ctx.height = 600
      ctx.height_units = "px"
    end
    doc = Celestine::Test.parse(svg)
    svg_node = Celestine::Test.find_node(doc, "svg").not_nil!
    Celestine::Test.attr(svg_node, "width").should eq("800px")
    Celestine::Test.attr(svg_node, "height").should eq("600px")
  end

  {% for type, tag in Celestine::Test::SVG_TAGS_SIMPLE %}
  it "should generate a {{type.id}}" do
    svg = Celestine.draw { |ctx| ctx.{{type.id}} { } }
    (!!(svg =~ /\<{{tag.id}}.*\>/)).should eq(true)
  end

  it "{{type.id}} should use inline element when there are no inner elements" do
    svg = Celestine.draw { |ctx| ctx.{{type.id}} { } }
    (!!(svg =~ /\<{{tag.id}}.*\/\>/)).should eq(true)
  end

  it "{{type.id}} should not use inline tags when there are inner elements" do
    svg = Celestine.draw { |ctx| ctx.{{type.id}} { |r| r.animate { } } }
    (!!(svg =~ /\<\/{{tag.id}}.*\>/)).should eq(true)
  end
  {% end %}
end
