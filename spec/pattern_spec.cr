describe Celestine::Pattern do
  it "should add a pattern element via DSL" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.pattern do |f|
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_pattern?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  it "should add a pattern element via DSL and reference it via fill" do
    celestine_svg = Celestine.draw do |ctx|
      pattern = ctx.pattern do |f|
        f.id = "my-pattern"
        f
      end

      ctx.rectangle do |r|
        r.set_fill pattern
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_pattern?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("fill").should eq("url(#my-pattern)")
    end
    parser.free
  end

  it "should add a pattern element via DSL and reference it via stroke" do
    celestine_svg = Celestine.draw do |ctx|
      pattern = ctx.pattern do |f|
        f.id = "my-pattern"
        f
      end

      ctx.rectangle do |r|
        r.set_stroke pattern
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_pattern?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("stroke").should eq("url(#my-pattern)")
    end
    parser.free
  end
end
