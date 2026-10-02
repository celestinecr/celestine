require "./spec_helper"

describe Celestine::Marker do
  it "should add a marker element in defs" do
    svg = Celestine.draw do |ctx|
      ctx.marker do |m|
        m.id = "arrow"
        m.ref_x = 0
        m.ref_y = 5
        m.width = 10
        m.height = 10
        m.orient = "auto"
      end
    end

    doc = Celestine::Test.parse(svg)
    marker = Celestine::Test.find_node(doc, "marker").not_nil!
    Celestine::Test.attr(marker, "id").should eq("arrow")
    Celestine::Test.attr(marker, "refx").should eq("0")
    Celestine::Test.attr(marker, "refy").should eq("5")
    Celestine::Test.attr(marker, "markerwidth").should eq("10")
    Celestine::Test.attr(marker, "markerheight").should eq("10")
    Celestine::Test.attr(marker, "orient").should eq("auto")
  end

  it "should add a marker element with inner elements" do
    svg = Celestine.draw do |ctx|
      ctx.marker do |m|
        m.id = "dot"
        m.circle do |c|
          c.radius = 3
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("marker circle").size.should eq(1)
  end

  it "should reference marker via start, mid, and end on paths" do
    svg = Celestine.draw do |ctx|
      ctx.marker { |m| m.id = "my-marker" }
      ctx.path do |p|
        p.set_marker_start "my-marker"
        p.set_marker_mid "my-marker"
        p.set_marker_end "my-marker"
      end
    end

    doc = Celestine::Test.parse(svg)
    path = Celestine::Test.find_node(doc, "path").not_nil!
    Celestine::Test.attr(path, "marker-start").should eq("url('#my-marker')")
    Celestine::Test.attr(path, "marker-mid").should eq("url('#my-marker')")
    Celestine::Test.attr(path, "marker-end").should eq("url('#my-marker')")
  end
end
