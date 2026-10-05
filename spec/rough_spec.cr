require "./spec_helper"

describe "Celestine::Rough Hand-Drawn Sketchy Generator" do
  it "draws sketchy rectangle and circle directly on a path" do
    svg = Celestine.draw do |ctx|
      ctx.path do |p|
        p.rough_rect(10, 10, 100, 50, roughness: 1.0, seed: 100_u64)
        p.rough_circle(200, 100, 30, roughness: 1.0, seed: 100_u64)
      end
    end

    output = svg.to_s
    output.should contain("<path ")
    output.should contain("M")
    output.should contain("Q")
  end

  it "produces deterministic output with same seed" do
    svg1 = Celestine.draw do |ctx|
      ctx.rough(roughness: 1.5, seed: 999_u64) do |r|
        r.rect(20, 20, 80, 80)
      end
    end

    svg2 = Celestine.draw do |ctx|
      ctx.rough(roughness: 1.5, seed: 999_u64) do |r|
        r.rect(20, 20, 80, 80)
      end
    end

    svg1.should eq(svg2)
  end

  it "supports builder DSL with line, rect, circle, and polygon" do
    svg = Celestine.draw do |ctx|
      ctx.rough(roughness: 2.0, stroke: "#334155", stroke_width: 2) do |r|
        r.line(10, 10, 100, 10)
        r.rect(20, 30, 80, 40)
        r.circle(60, 100, 25)
        r.polygon([{10, 150}, {50, 130}, {90, 160}])
      end
    end

    output = svg.to_s
    output.should contain("stroke=\"#334155\"")
    output.should contain("stroke-width=\"2\"")
    output.should contain("<path ")
    output.should contain("Q")
  end
end
