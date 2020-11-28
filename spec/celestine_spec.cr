require "./spec_helper"

module Celestine::Test
  BLANK_SVG = %Q[<svg width="100.0%" height="100.0%" xmlns="http://www.w3.org/2000/svg"></svg>]
  SVG_TAGS_SIMPLE = {
    "rectangle" => "rect",
    "circle" => "circle",
    "ellipse" => "ellipse",
    "path" => "path",
    "group" => "g",
    "image" => "image",
    "text" => "text"
  }

  UNITS = %w[px em rem ch vh vw in cm mm pt pc ex % vmin vmax]
end

describe Celestine do
  it "should generate a blank SVG document" do
    (Celestine.draw { |ctx| }).should eq(Celestine::Test::BLANK_SVG)
  end

  {% for type, tag in Celestine::Test::SVG_TAGS_SIMPLE %}

  it "should generate a {{type.id}}" do
    (!!(Celestine.draw { |ctx| ctx.{{type.id}} {|r| r} } =~ /\<{{tag.id}}.*\>/)).should eq(true)
  end

  it "{{type.id}} should use inline element when there are no inner elements" do
    (!!(Celestine.draw { |ctx| ctx.{{type.id}} {|r| r} } =~ /\<{{tag.id}}.*\/\>/)).should eq(true)
  end

  it "{{type.id}} should not use inline tags when there are inner elements" do
    (!!(Celestine.draw { |ctx| ctx.{{type.id}} {|r| r.animate {|a| a}; r} } =~ /\<\/{{tag.id}}.*\>/)).should eq(true)
  end

  {% end %}
end
