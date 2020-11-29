{% for drawable_class in Celestine::Meta::CLASSES %}
describe {{drawable_class.id}} do
  it "should add custom attributes" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.custom_attrs["test-attr"] = "Hello!"
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.attributes.size.should eq(1)
        child_element.attribute_by("test-attr").should eq("Hello!")
      else
        raise "No child element found"
      end
    end
    parser.free
  end

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::CPosition } %}

  make_number_attribute_test({{drawable_class.id}}, "cx", "x", units: true)
  make_number_attribute_test({{drawable_class.id}}, "cy", "y", units: true)

  {% elsif drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Position } %}

  make_number_attribute_test({{drawable_class.id}}, "x", units: true)
  make_number_attribute_test({{drawable_class.id}}, "y", units: true)

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Body } %}

  make_number_attribute_test({{drawable_class.id}}, "width", units: true)
  make_number_attribute_test({{drawable_class.id}}, "height", units: true)

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::StrokeFill } %}
  make_color_attribute_test({{drawable_class.id}}, "stroke")
  make_color_attribute_test({{drawable_class.id}}, "fill")
  make_number_attribute_test({{drawable_class.id}}, "stroke-width", "stroke_width", units: true)
  make_number_attribute_test({{drawable_class.id}}, "fill-opacity", "fill_opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "stroke-opacity", "stroke_opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "stroke-dashoffset", "dash_offset", units: true)
  make_number_attribute_test({{drawable_class.id}}, "stroke-miterlimit", "miter_limit", units: true)
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Animate } %}
  it "should add the animate element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.animate do |anim|
          anim
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        if child_element = child_element.child
          child_element.attributes.size.should eq(2)
          child_element.is_tag_animate?.should eq(true)
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free
  end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Animate::Transform } %}
  it "should add the animateTransform (rotate) element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.animate_transform_rotate do |anim|
          anim
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        if child_element = child_element.child
          child_element.attributes.size.should eq(3)
          child_element.is_tag_animatetransform?.should eq(true)
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free
  end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Animate::Motion } %}
  it "should add the animateMotion element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.animate_motion do |anim|
          anim
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        if child_element = child_element.child
          child_element.attributes.size.should eq(1)
          child_element.is_tag_animatemotion?.should eq(true)
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free
  end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Transform } %}
  it "should add the transform attribute via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.transform do |t|
          t.rotate(0, 0, 0)
          t.translate(99, 100)
          t.rotate(-33, 45, 22)
          t
        end
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      svg_root.children.size.should eq(1)
      if child_element = svg_root.child
        child_element.attribute_by("transform") == "rotate(0, 0, 0) translate(99, 100) rotate(-33, 45, 22) "
      else
        raise "No child element found"
      end
    end
    parser.free
  end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Marker } %}
  it "should add the marker attributes (start, mid, end) via DSL" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.marker {|m| m.id = "our-marker"; m}
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.set_marker_start "our-marker"
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_marker?.should eq true
          child_element.attribute_by("id").should eq "our-marker"
          parser.free
          parser = Myhtml::Parser.new celestine_svg
          if draw_element = parser.nodes(:svg).first.children.to_a[1]
            draw_element.attribute_by(Celestine::Modules::Marker::Attrs::START).should eq "url(\'#our-marker\')"
          else
            raise "No child element found"
          end
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free

    celestine_svg = Celestine.draw do |ctx|
      ctx.marker {|m| m.id = "our-marker"; m}
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.set_marker_mid "our-marker"
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_marker?.should eq true
          child_element.attribute_by("id").should eq "our-marker"
          parser.free
          parser = Myhtml::Parser.new celestine_svg
          if draw_element = parser.nodes(:svg).first.children.to_a[1]
            draw_element.attribute_by(Celestine::Modules::Marker::Attrs::MID).should eq "url(\'#our-marker\')"
          else
            raise "No child element found"
          end
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free

    celestine_svg = Celestine.draw do |ctx|
      ctx.marker {|m| m.id = "our-marker"; m}
      ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
        r.set_marker_end "our-marker"
        r
      end
    end
    parser = Myhtml::Parser.new celestine_svg
    if svg_root = parser.nodes(:svg).first
      if child_element = svg_root.child
        child_element.is_tag_defs?.should eq true
        if child_element = child_element.child
          child_element.is_tag_marker?.should eq true
          child_element.attribute_by("id").should eq "our-marker"
          parser.free
          parser = Myhtml::Parser.new celestine_svg
          if draw_element = parser.nodes(:svg).first.children.to_a[1]
            draw_element.attribute_by(Celestine::Modules::Marker::Attrs::END).should eq "url(\'#our-marker\')"
          else
            raise "No child element found"
          end
        else
          raise "No child element found"
        end
      else
        raise "No child element found"
      end
    end
    parser.free
  end
  {% end %}

end
{% end %}