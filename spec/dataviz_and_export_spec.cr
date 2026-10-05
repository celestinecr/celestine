require "./spec_helper"

describe "Celestine::DataViz & Export Primitives" do
  describe "Sparkline" do
    it "renders a basic sparkline" do
      svg = Celestine.draw do |ctx|
        ctx.sparkline([10, 40, 25, 60, 30, 80], x: 0, y: 0, width: 200, height: 50, stroke: "#3b82f6")
      end

      output = svg.to_s
      output.should contain("<path ")
      output.should contain("stroke=\"#3b82f6\"")
      output.should contain("M0.0,50.0")
      output.should contain("L200.0,0.0")
    end

    it "renders a smooth sparkline with area fill" do
      svg = Celestine.draw do |ctx|
        ctx.sparkline([5, 15, 10, 30, 20], x: 10, y: 10, width: 100, height: 40, smooth: true, fill: "rgba(59, 130, 246, 0.2)")
      end

      output = svg.to_s
      output.should contain("<path ")
      output.should contain("fill=\"rgba(59, 130, 246, 0.2)\"")
      output.should contain("C") # Smooth cubic beziers
      output.should contain("z") # Closed area baseline
    end
  end

  describe "Progress Ring" do
    it "renders a circular progress ring metric" do
      svg = Celestine.draw do |ctx|
        ctx.progress_ring(cx: 50, cy: 50, radius: 40, progress: 0.75, track_color: "#e2e8f0", fill_color: "#10b981", stroke_width: 6)
      end

      output = svg.to_s
      output.should contain("<g ")
      output.should contain("<circle ")
      output.should contain("stroke=\"#e2e8f0\"")
      output.should contain("<path ")
      output.should contain("stroke=\"#10b981\"")
      output.should contain("A40")
    end

    it "renders a full ring at 100% progress" do
      svg = Celestine.draw do |ctx|
        ctx.progress_ring(cx: 50, cy: 50, radius: 40, progress: 1.0, fill_color: "#6366f1")
      end

      output = svg.to_s
      output.should contain("<circle ")
      output.should contain("stroke=\"#6366f1\"")
    end
  end

  describe "Donut Slice" do
    it "renders an annular sector slice" do
      svg = Celestine.draw do |ctx|
        ctx.donut_slice(cx: 100, cy: 100, r_inner: 40, r_outer: 80, start_angle: 0, end_angle: 90, fill: "#f59e0b")
      end

      output = svg.to_s
      output.should contain("<path ")
      output.should contain("fill=\"#f59e0b\"")
      output.should contain("A80,80")
      output.should contain("A40,40")
      output.should contain("z")
    end
  end

  describe "Data URI Exporter" do
    it "exports SVG to UTF-8 data URI" do
      uri = Celestine.to_data_uri(:utf8) do |ctx|
        ctx.circle do |c|
          c.cx = 10
          c.cy = 10
          c.r = 5
        end
      end

      uri.should start_with("data:image/svg+xml;utf8,")
      uri.should contain("%3Ccircle")
    end

    it "exports SVG to Base64 data URI" do
      uri = Celestine.to_data_uri(:base64) do |ctx|
        ctx.circle do |c|
          c.cx = 10
          c.cy = 10
          c.r = 5
        end
      end

      uri.should start_with("data:image/svg+xml;base64,")
      decoded = Base64.decode_string(uri.sub("data:image/svg+xml;base64,", ""))
      decoded.should contain("<circle ")
    end
  end
end
