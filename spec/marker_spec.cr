describe Celestine::Marker do
  it "should add a marker element" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.marker do |m|
        m
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_marker?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  it "should add a marker element and inner elements" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.marker do |m|
        m.rectangle { |r| r }
        m
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_marker?.should eq true
          if child_element = child_element.child
            child_element.is_tag_rect?.should eq true
          else
            raise "bad child element"
          end
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end
end