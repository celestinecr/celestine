describe Celestine::Filter do
  it "should add a filter element" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        else
          raise "bad child element"
        end
      else
        raise "bad child element"
      end
    end
    parser.free
  end

  make_filter_test(Celestine::Filter::Blur, blur)
  make_filter_test(Celestine::Filter::Offset, offset)
  make_filter_test(Celestine::Filter::Morphology, morphology)
  make_filter_test(Celestine::Filter::Merge, merge)
  make_filter_test(Celestine::Filter::Blend, blend)
  make_filter_test(Celestine::Filter::ColorMatrix, color_matrix)
  make_filter_test(Celestine::Filter::ComponentTransfer, component_transfer)
  make_filter_test(Celestine::Filter::Flood, flood)
  make_filter_test(Celestine::Filter::DisplacementMap, displacement_map)
  make_filter_test(Celestine::Filter::SpecularLighting, specular_lighting)
  make_filter_test(Celestine::Filter::Turbulence, turbulence)
  make_filter_test(Celestine::Filter::Composite, composite)
  make_filter_test(Celestine::Filter::Tile, tile)
  make_filter_test(Celestine::Filter::Image, image)


  it "should properly format color_matrix values" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.color_matrix do |f|
          10.times do 
            f.values << 0
            f.values << 1
          end
      
          f
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_fecolormatrix?.should eq true
          child_element.attribute_by("values").should eq "0 1 0 1 0, 1 0 1 0 1, 0 1 0 1 0, 1 0 1 0 1"
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end


  {% for char in ["r", "g", "b", "a"] %}
    it "should add a feFunc{{char.upcase.id}} element to feComponentTransfer" do
      celestine_svg = Celestine.draw do |ctx| 
        ctx.filter do |f|
          f.component_transfer do |ct|
            ct.func_{{char.downcase.id}}_identity
            ct
          end
          f
        end
      end
      parser = Myhtml::Parser.new celestine_svg
      if svg_root = parser.nodes(:svg).first
        svg_root.children.size.should eq(1)
        if child_element = svg_root.child
          child_element.is_tag_defs?.should eq true
          if child_element = child_element.child
            child_element.is_tag_filter?.should eq true
            if child_element = child_element.child
              child_element.is_tag_fecomponenttransfer?.should eq true
              if child_element = child_element.child
                child_element.is_tag_fefunc{{char.downcase.id}}?.should eq true
              else
                raise "bad child element"
              end
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
  {% end %}

  it "should add a merge node filter element" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.merge do |b|
          b.add_node(Celestine::Filter::SOURCE_GRAPHIC)
          b 
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_femerge?.should eq true
          if child_element = child_element.child
            child_element.is_tag_femergenode?.should eq true
          else
            raise "no child"
          end
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end

  it "should add a point light element to specular lighting" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.specular_lighting do |b|
          b.add_point_light(0, 1, 2)
          b 
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_fespecularlighting?.should eq true
          if child_element = child_element.child
            child_element.is_tag_fepointlight?.should eq true
          else
            raise "no child"
          end
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end

  it "should add a spot light element to specular lighting" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.specular_lighting do |b|
          b.add_spot_light(0, 1, 2, 4, 5, 6, 7)
          b 
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_fespecularlighting?.should eq true
          if child_element = child_element.child
            child_element.is_tag_fespotlight?.should eq true
          else
            raise "no child"
          end
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end

  it "should add a distant light element to specular lighting" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.specular_lighting do |b|
          b.add_distant_light(0, 1)
          b 
        end
        f
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_filter?.should eq true
        if child_element = child_element.child
          child_element.is_tag_fespecularlighting?.should eq true
          if child_element = child_element.child
            child_element.is_tag_fedistantlight?.should eq true
          else
            raise "no child"
          end
        else
          raise "no child"
        end
        else
          raise "no child"
        end
      else
        raise "no child"
      end
    end
    parser.free
  end
end