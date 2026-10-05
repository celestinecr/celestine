require "./spec_helper"

describe Celestine::Pattern do
  it "should add a pattern element in defs via DSL" do
    svg = Celestine.draw do |ctx|
      ctx.pattern do |p|
        p.id = "my-pattern"
        p.width = 20
        p.height = 20
      end
    end

    doc = Celestine::Test.parse(svg)
    pat = Celestine::Test.find_node(doc, "pattern").not_nil!
    Celestine::Test.attr(pat, "id").should eq("my-pattern")
    Celestine::Test.attr(pat, "width").should eq("20")
    Celestine::Test.attr(pat, "height").should eq("20")
    doc.css("defs pattern").size.should eq(1)
  end

  it "should reference pattern via fill and stroke" do
    svg = Celestine.draw do |ctx|
      pat = ctx.pattern do |p|
        p.id = "stripes"
      end

      ctx.rectangle do |r|
        r.set_fill pat
        r.set_stroke pat
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(rect, "fill").should eq("url(#stripes)")
    Celestine::Test.attr(rect, "stroke").should eq("url(#stripes)")
  end
end
