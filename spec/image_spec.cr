describe Celestine::Image do
  it "should use href" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.image do |r| 
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
end