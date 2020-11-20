require "./spec_helper"

module Celestine::Test
  BLANK_SVG = %Q[<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg"><defs></defs></svg>]
  SVG_TAGS_SIMPLE = {
    "rectangle" => "rect",
    "circle" => "circle",
    "ellipse" => "ellipse",
    "path" => "path",
    "group" => "g",
    "image" => "image",
    "text" => "text"
  }
end

describe Celestine do
  it "should generate a blank SVG document" do
    (Celestine.draw { |ctx| }).should eq(Celestine::Test::BLANK_SVG)
  end

  {% for type, tag in Celestine::Test::SVG_TAGS_SIMPLE %}

  it "should generate a {{type.id}}" do
    (!!(Celestine.draw { |ctx| ctx.{{type.id}} {|r| r} } =~ /\<{{tag.id}}/)).should eq(true)
  end

  {% end %}
end
