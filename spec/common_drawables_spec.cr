{% for drawable_class in Celestine::Meta::CLASSES %}
describe {{drawable_class.id}} do
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
        child_element.attributes.size.should eq(0)
        if child_element = child_element.child
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
        child_element.attributes.size.should eq(0)
        if child_element = child_element.child
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
        child_element.attributes.size.should eq(0)
        if child_element = child_element.child
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
end
{% end %}