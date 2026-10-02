require "./spec_helper"

describe Celestine::Image do
  it "should use href and rendering" do
    svg = Celestine.draw do |ctx|
      ctx.image do |img|
        img.href = "test.png"
        img.rendering = "optimizeQuality"
        img.x = 10
        img.y = 20
        img.width = 200
        img.height = 150
      end
    end

    doc = Celestine::Test.parse(svg)
    img_node = Celestine::Test.find_node(doc, "image").not_nil!
    Celestine::Test.attr(img_node, "href").should eq("test.png")
    Celestine::Test.attr(img_node, "image-rendering").should eq("optimizeQuality")
    Celestine::Test.attr(img_node, "x").should eq("10")
    Celestine::Test.attr(img_node, "y").should eq("20")
    Celestine::Test.attr(img_node, "width").should eq("200")
    Celestine::Test.attr(img_node, "height").should eq("150")
  end
end
