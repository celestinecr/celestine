require "./spec_helper"

describe "Celestine::Path Fluent & Procedural DSL" do
  it "supports fluent command chaining" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.move_to(10, 20)
         .line_to(100, 20)
         .curve_to(120, 20, 150, 50, 150, 80)
         .quad_to(100, 120, 50, 80)
         .arc_to(30, 30, rotation: 0, large: false, sweep: true, x: 10, y: 50)
         .close
      end
    end

    output = svg.to_s
    output.should contain("M10,20")
    output.should contain("L100,20")
    output.should contain("C120,20 150,50 150,80")
    output.should contain("Q100,120 50,80")
    output.should contain("A30,30,0,0,1,10,50")
    output.should contain("z")
  end

  it "supports Point and Tuple overloads" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        pt = Celestine::Point.new(50, 60)
        p.move_to({10, 20})
         .line_to(pt)
         .line_by({5, -5})
         .close_path
      end
    end

    output = svg.to_s
    output.should contain("M10,20")
    output.should contain("L50,60")
    output.should contain("l5,-5")
    output.should contain("z")
  end

  it "generates regular polygon paths" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.regular_polygon(cx: 100, cy: 100, sides: 6, radius: 50)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("M100.0,50.0") # Start angle -90 deg points straight up
    output.should contain("z")
  end

  it "generates star paths" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.star(cx: 100, cy: 100, points: 5, outer_radius: 50, inner_radius: 25)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("M100.0,50.0")
    output.should contain("z")
  end

  it "generates arc sector (annular sector) paths" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.arc_sector(cx: 100, cy: 100, r_inner: 40, r_outer: 80, start_angle: 0, end_angle: 90)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("A80,80")
    output.should contain("A40,40")
    output.should contain("z")
  end

  it "generates rounded rect paths" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.rounded_rect(x: 10, y: 20, width: 200, height: 100, rx: 15)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("M25,20")
    output.should contain("H195")
    output.should contain("A15,15")
    output.should contain("z")
  end

  it "generates heart paths" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.heart(cx: 100, cy: 100, size: 60)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("C")
    output.should contain("z")
  end

  it "supports turtle graphics mode" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.turtle(start_x: 50, start_y: 50, angle: 0.0) do |t|
          4.times do
            t.forward(100)
             .turn_right(90)
          end
          t.close
        end
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("M50.0,50.0")
    output.should contain("L150.0,50.0")
    output.should contain("L150.0,150.0")
    output.should contain("L50.0,150.0")
    output.should contain("z")
  end
end
