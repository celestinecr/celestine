require "./spec_helper"

describe Celestine::Animate do
  it "should render animate element with numeric from and to" do
    svg = Celestine.draw do |ctx|
      ctx.circle do |c|
        c.radius = 10
        c.animate do |a|
          a.attribute = "r"
          a.from = 10
          a.to = 50
          a.duration = 2.5
          a.duration_units = "s"
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    anim = Celestine::Test.find_node(doc, "animate").not_nil!
    Celestine::Test.attr(anim, "attributename").should eq("r")
    Celestine::Test.attr(anim, "from").should eq("10")
    Celestine::Test.attr(anim, "to").should eq("50")
    Celestine::Test.attr(anim, "dur").should eq("2.5s")
  end

  it "should render animate element with string/color from_value and to_value" do
    svg = Celestine.draw do |ctx|
      ctx.rectangle do |r|
        r.animate do |a|
          a.attribute = "fill"
          a.from_value = "red"
          a.to_value = "blue"
          a.duration = 1
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    anim = Celestine::Test.find_node(doc, "animate").not_nil!
    Celestine::Test.attr(anim, "attributename").should eq("fill")
    Celestine::Test.attr(anim, "from").should eq("red")
    Celestine::Test.attr(anim, "to").should eq("blue")
  end

  it "should render animate element with values and key_times" do
    svg = Celestine.draw do |ctx|
      ctx.circle do |c|
        c.animate do |a|
          a.attribute = "opacity"
          a.values = [0.0, 0.5, 1.0] of SIFNumber
          a.key_times = [0.0, 0.5, 1.0]
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    anim = Celestine::Test.find_node(doc, "animate").not_nil!
    Celestine::Test.attr(anim, "values").should eq("0.0;0.5;1.0")
    Celestine::Test.attr(anim, "keytimes").should eq("0.0;0.5;1.0")
  end

  it "should render animateMotion element" do
    svg = Celestine.draw do |ctx|
      ctx.circle do |c|
        c.animate_motion do |m|
          m.mpath = Celestine::Path.new.tap { |p| p.a_move(0, 0); p.a_line(100, 100) }
          m.rotate = "auto"
          m.duration = 5
          m.duration_units = "s"
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    anim = Celestine::Test.find_node(doc, "animatemotion").not_nil!
    Celestine::Test.attr(anim, "path").should eq("M0,0L100,100")
    Celestine::Test.attr(anim, "rotate").should eq("auto")
    Celestine::Test.attr(anim, "dur").should eq("5s")
  end

  it "should render animateTransform rotate and scale" do
    svg = Celestine.draw do |ctx|
      ctx.rectangle do |r|
        r.animate_transform_rotate do |tr|
          tr.from = "0 50 50"
          tr.to = "360 50 50"
          tr.duration = 3
        end
        r.animate_transform_scale do |ts|
          ts.from = "1"
          ts.to = "2"
        end
      end
    end

    doc = Celestine::Test.parse(svg)
    transforms = doc.css("animatetransform")
    transforms.size.should eq(2)
    Celestine::Test.attr(transforms[0], "type").should eq("rotate")
    Celestine::Test.attr(transforms[0], "from").should eq("0 50 50")
    Celestine::Test.attr(transforms[0], "to").should eq("360 50 50")
    Celestine::Test.attr(transforms[1], "type").should eq("scale")
  end
end
