require "./spec_helper"

describe Celestine::Use do
  it "should instantiate Use with string id constructor without errors" do
    u = Celestine::Use.new("symbol-1")
    u.target_id.should eq("symbol-1")
  end

  it "should instantiate Use with Drawable target" do
    rect = Celestine::Rectangle.new
    rect.id = "my-rect"
    u = Celestine::Use.new(rect)
    u.target_id.should eq("my-rect")
  end

  it "should raise when initializing Use with a target without id" do
    rect = Celestine::Rectangle.new
    expect_raises(Exception, "No id on target") do
      Celestine::Use.new(rect)
    end
  end

  it "should render use element referencing an id" do
    svg = Celestine.draw do |ctx|
      ctx.rectangle(define: true) do |r|
        r.id = "template-rect"
        r.width = 50
        r.height = 50
      end

      ctx.use("template-rect") do |u|
        u.x = 100
        u.y = 150
        u.fill = "red"
      end
    end

    doc = Celestine::Test.parse(svg)
    use_node = Celestine::Test.find_node(doc, "use").not_nil!
    Celestine::Test.attr(use_node, "href").should eq("#template-rect")
    Celestine::Test.attr(use_node, "x").should eq("100")
    Celestine::Test.attr(use_node, "y").should eq("150")
    Celestine::Test.attr(use_node, "fill").should eq("red")
  end

  it "should render use element referencing a drawable instance" do
    svg = Celestine.draw do |ctx|
      c = ctx.circle(define: true) do |c|
        c.id = "template-circle"
        c.radius = 20
      end

      ctx.use(c) do |u|
        u.x = 30
        u.y = 40
      end
    end

    doc = Celestine::Test.parse(svg)
    use_node = Celestine::Test.find_node(doc, "use").not_nil!
    Celestine::Test.attr(use_node, "href").should eq("#template-circle")
  end
end
