require "./spec_helper"

{% for drawable_class in Celestine::Meta::CLASSES %}
{% if drawable_class.stringify != "Celestine::Svg" %}
describe {{drawable_class.id}} do
  it "should add custom attributes" do
    svg = Celestine.draw do |ctx|
      ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
        r.custom_attrs["test-attr"] = "Hello!"
      end
    end
    doc = Celestine::Test.parse(svg)
    tag = {{drawable_class.resolve.constant(:TAG).downcase}}
    elem = Celestine::Test.find_node(doc, tag)
    elem.should_not be_nil
    Celestine::Test.attr(elem.not_nil!, "test-attr").should eq("Hello!")
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
      svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.animate do |anim|
            anim.attribute = "opacity"
          end
        end
      end
      doc = Celestine::Test.parse(svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      doc.css("#{tag} animate").size.should eq(1)
    end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Animate::Transform } %}
    it "should add the animateTransform (rotate) element via DSL" do
      svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.animate_transform_rotate do |anim|
            anim.from = "0"
            anim.to = "90"
          end
        end
      end
      doc = Celestine::Test.parse(svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      doc.css("#{tag} animatetransform").size.should eq(1)
    end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Animate::Motion } %}
    it "should add the animateMotion element via DSL" do
      svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.animate_motion do |anim|
            anim.rotate = "auto"
          end
        end
      end
      doc = Celestine::Test.parse(svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      doc.css("#{tag} animatemotion").size.should eq(1)
    end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Transform } %}
    it "should add the transform attribute via DSL" do
      svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.transform do |t|
            t.rotate(0, 0, 0)
            t.translate(99, 100)
            t.rotate(-33, 45, 22)
          end
        end
      end
      doc = Celestine::Test.parse(svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      elem = Celestine::Test.find_node(doc, tag)
      elem.should_not be_nil
      Celestine::Test.attr(elem.not_nil!, "transform").should eq("rotate(0 0 0) translate(99,100) rotate(-33 45 22) ")
    end
  {% end %}

  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Marker } %}
    it "should add the marker attributes (start, mid, end) via DSL" do
      svg = Celestine.draw do |ctx|
        ctx.marker { |m| m.id = "our-marker" }
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.set_marker_start "our-marker"
          r.set_marker_mid "our-marker"
          r.set_marker_end "our-marker"
        end
      end
      doc = Celestine::Test.parse(svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      elem = Celestine::Test.find_node(doc, tag)
      elem.should_not be_nil
      Celestine::Test.attr(elem.not_nil!, "marker-start").should eq("url('#our-marker')")
      Celestine::Test.attr(elem.not_nil!, "marker-mid").should eq("url('#our-marker')")
      Celestine::Test.attr(elem.not_nil!, "marker-end").should eq("url('#our-marker')")
    end
  {% end %}
end
{% end %}
{% end %}
