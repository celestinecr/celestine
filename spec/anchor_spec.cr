require "./spec_helper"

describe Celestine::Anchor do
  it "should use href" do
    svg = Celestine.draw do |ctx|
      ctx.anchor do |a|
        a.href = "https://crystal-lang.org"
      end
    end

    doc = Celestine::Test.parse(svg)
    a_node = Celestine::Test.find_node(doc, "a").not_nil!
    Celestine::Test.attr(a_node, "href").should eq("https://crystal-lang.org")
  end

  it "should be able to use context methods for children" do
    svg = Celestine.draw do |ctx|
      ctx.anchor do |a|
        a.href = "/home"
        a.rectangle do |r|
          r.width = 100
          r.height = 50
        end
        a.circle do |c|
          c.radius = 20
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    doc.css("a rect").size.should eq(1)
    doc.css("a circle").size.should eq(1)
  end
end
