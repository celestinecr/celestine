require "./spec_helper"
describe Celestine::Anchor do
  it "should use href" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.anchor do |r|
        r.href = "/test"
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.attributes.size.should eq(1)
        child_element.attribute_by("href").should eq("/test")
      else
        raise "No child element found"
      end
    end
    parser.free
  end

  it "should be able to use context methods" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.anchor do |r|
        r.rectangle do |r|
          r
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.children.size.should eq(1)
      else
        raise "No child element found"
      end
    end
    parser.free
  end

  it "should be able to use context methods 2" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.anchor do |r|
        3.times do
          r.rectangle do |r|
            r
          end
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.children.size.should eq(3)
      else
        raise "No child element found"
      end
    end
    parser.free
  end
end
