require "spec"
require "../src/celestine"
require "file_utils"
require "procedural_art"

macro make_number_attribute_test(drawable_class, attr_name, units = false)
  make_number_attribute_test({{drawable_class.id}}, {{attr_name}}, {{attr_name}}, units)
end

# Creates a test that runs different types of numbers through an attribute and then parses and searches for it. It also makes sure it is the only attribute,
# as well as it only has one child element, the `{{drawable_class.id}}`
macro make_number_attribute_test(drawable_class, attr_name_html, attr_name_cr, units = false)
  it "should set attribute {{attr_name_html.id}} via {{attr_name_cr.id}} and there should be no other attributes set" do
    positive_values = [0, 1.0, 2, 4, 0.22, 99.0, 60000.0, 99999.9999]
    values = positive_values.clone
    positive_values.each { |v| values << -v }
    
    values.each do |v|
      celestine_svg = Celestine.draw do |ctx| 
        ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
          r.{{attr_name_cr.id}} = v
          # Check to see if using the value throws an error
          if w = r.{{attr_name_cr.id}}
            s = w / 2 
          end
          r 
        end
      end
      parser = Myhtml::Parser.new celestine_svg
      if svg_root = parser.nodes(:svg).first
        svg_root.children.size.should eq(1)
        if child_element = svg_root.child
          child_element.attributes.size.should eq(1)
          (child_element.attribute_by({{attr_name_html}}) == v.to_s).should eq(true)
        end
      end
      parser.free
    end

    {% if units == true %}
    Celestine::Test::UNITS.each do |unit|
      values.each do |v|
        celestine_svg = Celestine.draw do |ctx|
          ctx.{{drawable_class.id.split("::").last.underscore.id}} do |r| 
            r.{{attr_name_cr.id}} = v
            r.{{attr_name_cr.id}}_units = unit
            r
          end
        end 
        parser = Myhtml::Parser.new celestine_svg
        if svg_root = parser.nodes(:svg).first
          svg_root.children.size.should eq(1)
          if child_element = svg_root.child
            child_element.attributes.size.should eq(1)
            (child_element.attribute_by({{attr_name_html}}) == "#{v}#{unit}").should eq(true)
          end
        end
        parser.free
      end
    end
    {% end %}
  end
end

macro make_color_attribute_test(drawable_class, attr_name)
  make_color_attribute_test({{drawable_class.id}}, {{attr_name}}, {{attr_name}})
end

macro make_color_attribute_test(drawable_class, attr_name_html, attr_name_cr)
  it "should set attribute {{attr_name_html.id}} via {{attr_name_cr.id}}" do
    values = ["black", "red", "pink", "#121212", "#ABCDEF", "#1A2B3C"]
    values.each do |v|
      celestine_svg = Celestine.draw { |ctx| ctx.{{drawable_class.id.split("::").last.underscore.id}} {|r| r.{{attr_name_cr.id}} = v; r} }
      parser = Myhtml::Parser.new celestine_svg
      if svg_root = parser.nodes(:svg).first
        svg_root.children.size.should eq(1)
        if child_element = svg_root.child
          child_element.attributes.size.should eq(1)
          (child_element.attribute_by({{attr_name_html}}) == v.to_s).should eq(true)
        end
      end
      parser.free
    end
  end
end

macro make_filter_test(filter_class, filter_method)
  it "should add a {{filter_method.id}} filter element via DSL" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.{{filter_method.id}} do |b|
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
            child_element.is_tag_{{filter_class.resolve.constant(:TAG).downcase.id}}?.should eq true
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

  it "should add a {{filter_method.id}} filter element via DSL and set result" do
    celestine_svg = Celestine.draw do |ctx| 
      ctx.filter do |f|
        f.{{filter_method.id}} do |b|
          b.result = "HELLOWORLD"
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
            child_element.is_tag_{{filter_class.resolve.constant(:TAG).downcase.id}}?.should eq true
            child_element.attribute_by("result").should eq "HELLOWORLD"
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

