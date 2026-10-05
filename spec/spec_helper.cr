require "spec"
require "lexbor"
require "xml"
require "../src/celestine"

module Celestine::Test
  BLANK_SVG = "<svg xmlns=\"http://www.w3.org/2000/svg\" />"
  SVG_TAGS_SIMPLE = {
    "rectangle" => "rect",
    "circle"    => "circle",
    "ellipse"   => "ellipse",
    "line"      => "line",
    "polygon"   => "polygon",
    "polyline"  => "polyline",
    "path"      => "path",
    "group"     => "g",
    "image"     => "image",
    "text"      => "text",
    "anchor"    => "a",
  }

  UNITS = %w[px em rem ch vh vw in cm mm pt pc ex % vmin vmax]

  def self.parse(svg_str : String) : Lexbor::Parser
    Lexbor.new(svg_str)
  end

  def self.find_node(doc : Lexbor::Parser, selector : String) : Lexbor::Node?
    doc.css(selector).first?
  end

  def self.attr(node : Lexbor::Node, name : String) : String?
    node[name.downcase]?
  end
end

macro make_number_attribute_test(drawable_class, attr_name, units = false)
  make_number_attribute_test({{drawable_class.id}}, {{attr_name}}, {{attr_name}}, units)
end

# Creates a test that runs different types of numbers through an attribute and then parses and searches for it.
macro make_number_attribute_test(drawable_class, attr_name_html, attr_name_cr, units = false)
  it "should set attribute {{attr_name_html.id}} via {{attr_name_cr.id}}" do
    positive_values = [0, 1.0, 2, 4, 0.22, 99.0, 60000.0, 99999.9999]
    values = positive_values.clone
    positive_values.each { |v| values << -v }

    values.each do |v|
      celestine_svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.{{attr_name_cr.id}} = v
          if w = r.{{attr_name_cr.id}}
            s = w / 2
          end
        end
      end
      doc = Celestine::Test.parse(celestine_svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      element = Celestine::Test.find_node(doc, tag)
      element.should_not be_nil
      if el = element
        Celestine::Test.attr(el, {{attr_name_html}}).should eq(v.to_s)
      end
    end

    {% if units == true %}
    Celestine::Test::UNITS.each do |unit|
      values.each do |v|
        celestine_svg = Celestine.draw do |ctx|
          ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
            r.{{attr_name_cr.id}} = v
            r.{{attr_name_cr.id}}_units = unit
          end
        end
        doc = Celestine::Test.parse(celestine_svg)
        tag = {{drawable_class.resolve.constant(:TAG).downcase}}
        element = Celestine::Test.find_node(doc, tag)
        element.should_not be_nil
        if el = element
          Celestine::Test.attr(el, {{attr_name_html}}).should eq("#{v}#{unit}")
        end
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
      celestine_svg = Celestine.draw do |ctx|
        ctx.{{drawable_class.id.split("::").last.downcase.id}} do |r|
          r.{{attr_name_cr.id}} = v
        end
      end
      doc = Celestine::Test.parse(celestine_svg)
      tag = {{drawable_class.resolve.constant(:TAG).downcase}}
      element = Celestine::Test.find_node(doc, tag)
      element.should_not be_nil
      if el = element
        Celestine::Test.attr(el, {{attr_name_html}}).should eq(v.to_s)
      end
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
      end
    end
    doc = Celestine::Test.parse(celestine_svg)
    filter_elem = Celestine::Test.find_node(doc, "filter")
    filter_elem.should_not be_nil

    tag = {{filter_class.resolve.constant(:TAG).downcase}}
    primitive = Celestine::Test.find_node(doc, tag)
    primitive.should_not be_nil
  end

  it "should add a {{filter_method.id}} filter element via DSL and set result" do
    celestine_svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.{{filter_method.id}} do |b|
          b.result = "HELLOWORLD"
        end
      end
    end
    doc = Celestine::Test.parse(celestine_svg)
    tag = {{filter_class.resolve.constant(:TAG).downcase}}
    primitive = Celestine::Test.find_node(doc, tag)
    primitive.should_not be_nil
    if p = primitive
      Celestine::Test.attr(p, "result").should eq("HELLOWORLD")
    end
  end
end
