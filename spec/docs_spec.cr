require "./spec_helper"

describe Celestine::Docs do
  it "should execute topic methods without error" do
    Celestine::Docs.quick_start.should be_nil
    Celestine::Docs.reading_paths.should be_nil
    Celestine::Docs.table_of_contents.should be_nil
  end

  it "should run the getting started overview code example" do
    svg = Celestine.draw do |ctx|
      ctx.view_box = {x: 0, y: 0, w: 200, h: 200}
      ctx.rectangle do |r|
        r.x = 10
        r.y = 10
        r.width = 180
        r.height = 180
        r.fill = "blue"
        r.radius_x = 8
        r.radius_y = 8
      end
    end

    doc = Celestine::Test.parse(svg)
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(rect, "fill").should eq("blue")
    Celestine::Test.attr(rect, "rx").should eq("8")
    Celestine::Test.attr(rect, "ry").should eq("8")
  end

  it "should run the quickstart usage guide code examples" do
    # Example 1: Stream to IO::Memory
    io = IO::Memory.new
    Celestine.draw(io) do |ctx|
      ctx.circle do |c|
        c.x = 50
        c.y = 50
        c.radius = 40
        c.fill = "#ff007f"
      end
    end
    svg_from_io = io.to_s
    doc1 = Celestine::Test.parse(svg_from_io)
    circle = Celestine::Test.find_node(doc1, "circle").not_nil!
    Celestine::Test.attr(circle, "fill").should eq("#ff007f")

    # Example 2: Reusable star shape with <defs> and <use>
    svg2 = Celestine.draw do |ctx|
      ctx.path(define: true) do |p|
        p.id = "star-shape"
        p.a_move(10, 1)
        p.a_line(4, 19)
        p.close
        p.fill = "gold"
      end

      ctx.use("star-shape") do |u|
        u.x = 10
        u.y = 10
      end
    end
    doc2 = Celestine::Test.parse(svg2)
    use_node = Celestine::Test.find_node(doc2, "use").not_nil!
    Celestine::Test.attr(use_node, "href").should eq("#star-shape")
    Celestine::Test.attr(use_node, "x").should eq("10")
  end

  it "should run the filters and effects code examples" do
    svg = Celestine.draw do |ctx|
      ctx.filter do |f|
        f.id = "soft-glow"
        f.blur do |b|
          b.input = Celestine::Filter::SOURCE_GRAPHIC
          b.std_deviation = 5
          b.result = "blur-out"
        end
        f.merge do |m|
          m.add_node("blur-out")
          m.add_node(Celestine::Filter::SOURCE_GRAPHIC)
        end
      end

      grad = ctx.linear_gradient do |g|
        g.id = "sunset"
        g.stop(0, color: "#ff512f")
        g.stop(1, color: "#dd2476")
      end

      ctx.rectangle do |r|
        r.width = 200
        r.height = 100
        r.set_fill(grad)
        r.set_filter("soft-glow")
      end
    end

    doc = Celestine::Test.parse(svg)
    filter = Celestine::Test.find_node(doc, "filter").not_nil!
    rect = Celestine::Test.find_node(doc, "rect").not_nil!
    Celestine::Test.attr(filter, "id").should eq("soft-glow")
    Celestine::Test.attr(rect, "fill").should eq("url(#sunset)")
    Celestine::Test.attr(rect, "filter").should eq("url('##{"soft-glow"}')")
  end
end
