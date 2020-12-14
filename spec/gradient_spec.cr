describe Celestine::Gradient::Linear do
  it "should add a linear gradient element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.linear_gradient do |f|
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_lineargradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  it "should add a linear gradient element via DSL and add stops as children" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.linear_gradient do |f|
        f.stop {|s| s}
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_lineargradient?.should eq true
          if child_element = child_element.child
            child_element.is_tag_stop?.should eq true
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

  it "should add a linear gradient  element via DSL and reference it via fill" do
    celestine_svg = Celestine.draw do |ctx| 
      linear_gradient = ctx.linear_gradient do |f|
        f.id = "my-gradient"
        f
      end

      ctx.rectangle do |r|
        r.set_fill linear_gradient
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_lineargradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("fill").should eq("url(#my-gradient)")
    end
    parser.free
  end

  it "should add a linear gradient element via DSL and reference it via stroke" do
    celestine_svg = Celestine.draw do |ctx| 
      linear_gradient = ctx.linear_gradient do |f|
        f.id = "my-gradient"
        f
      end

      ctx.rectangle do |r|
        r.set_stroke linear_gradient
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_lineargradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("stroke").should eq("url(#my-gradient)")
    end
    parser.free
  end
end


describe Celestine::Gradient::Radial do
  it "should add a radial gradient element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.radial_gradient do |f|
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_radialgradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  it "should add a radial gradient element via DSL and add stops as children" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.radial_gradient do |f|
        f.stop {|s| s}
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_radialgradient?.should eq true
          if child_element = child_element.child
            child_element.is_tag_stop?.should eq true
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

  it "should add a radial gradient  element via DSL and reference it via fill" do
    celestine_svg = Celestine.draw do |ctx| 
      radial_gradient = ctx.radial_gradient do |f|
        f.id = "my-gradient"
        f
      end

      ctx.rectangle do |r|
        r.set_fill radial_gradient
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_radialgradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("fill").should eq("url(#my-gradient)")
    end
    parser.free
  end

  it "should add a radial gradient element via DSL and reference it via stroke" do
    celestine_svg = Celestine.draw do |ctx| 
      radial_gradient = ctx.radial_gradient do |f|
        f.id = "my-gradient"
        f
      end

      ctx.rectangle do |r|
        r.set_stroke radial_gradient
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(2)
      if defs_element = parser.nodes(:defs).first
        if child_element = defs_element.child
          child_element.is_tag_radialgradient?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end

    if rect_element = parser.nodes(:rect).first
      rect_element.attribute_by("stroke").should eq("url(#my-gradient)")
    end
    parser.free
  end
end