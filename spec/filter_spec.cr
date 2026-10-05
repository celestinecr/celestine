require "./spec_helper"

describe Celestine::Filter do
  it "should add a filter element in defs" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.id = "my-filter"
      end
    end

    doc = Celestine::Test.parse(svg)
    filter_elem = Celestine::Test.find_node(doc, "filter").not_nil!
    Celestine::Test.attr(filter_elem, "id").should eq("my-filter")
    doc.css("defs filter").size.should eq(1)
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
  make_filter_test(Celestine::Filter::DropShadow, drop_shadow)

  it "should properly format color_matrix values" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.color_matrix do |cm|
          10.times do
            cm.values << 0
            cm.values << 1
          end
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    cm_node = Celestine::Test.find_node(doc, "fecolormatrix").not_nil!
    Celestine::Test.attr(cm_node, "values").should eq("0 1 0 1 0, 1 0 1 0 1, 0 1 0 1 0, 1 0 1 0 1")
  end

  {% for char in ["r", "g", "b", "a"] %}
  it "should add a feFunc{{char.upcase.id}} element to feComponentTransfer" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.component_transfer do |ct|
          ct.func_{{char.downcase.id}}_identity
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    ct_node = Celestine::Test.find_node(doc, "fecomponenttransfer").not_nil!
    func_node = Celestine::Test.find_node(doc, "fefunc{{char.downcase.id}}").not_nil!
    Celestine::Test.attr(func_node, "type").should eq("identity")
  end
  {% end %}

  it "should add a merge node filter element" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.merge do |m|
          m.add_node(Celestine::Filter::SOURCE_GRAPHIC)
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("femerge femergenode").size.should eq(1)
  end

  it "should add a point light element to specular lighting" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.specular_lighting do |sl|
          sl.add_point_light(0, 1, 2)
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("fespecularlighting fepointlight").size.should eq(1)
  end

  it "should add a spot light element to specular lighting" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.specular_lighting do |sl|
          sl.add_spot_light(0, 1, 2, 4, 5, 6, 7)
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("fespecularlighting fespotlight").size.should eq(1)
  end

  it "should add a distant light element to specular lighting" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.specular_lighting do |sl|
          sl.add_distant_light(0, 1)
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("fespecularlighting fedistantlight").size.should eq(1)
  end
end
