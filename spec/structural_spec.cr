require "./spec_helper"

describe "Celestine Structural & Spec Parity Elements" do
  describe "Symbol & Use" do
    it "defines a symbol with viewBox and instantiates it with use" do
      svg = Celestine.draw do |ctx|
        sym = ctx.symbol("star-icon") do |s|
          s.view_box = "0 0 100 100"
          s.circle do |c|
            c.cx = 50
            c.cy = 50
            c.radius = 40
            c.fill = "gold"
          end
        end

        ctx.use(sym) do |u|
          u.x = 10
          u.y = 10
          u.width = 50
          u.height = 50
        end
      end

      output = svg.to_s
      output.should contain("<defs>")
      output.should contain("<symbol ")
      output.should contain("id=\"star-icon\"")
      output.should contain("viewBox=\"0 0 100 100\"")
      output.should contain("<circle ")
      output.should contain("</symbol>")
      output.should contain("</defs>")
      output.should contain("<use ")
      output.should contain("href=\"#star-icon\"")
      output.should contain("x=\"10\"")
      output.should contain("width=\"50\"")
    end
  end

  describe "ClipPath" do
    it "defines a clipPath and applies it to a rectangle" do
      svg = Celestine.draw do |ctx|
        clip = ctx.clip_path("rounded-cut") do |cp|
          cp.circle do |c|
            c.cx = 100
            c.cy = 100
            c.radius = 80
          end
        end

        ctx.rectangle do |r|
          r.x = 20
          r.y = 20
          r.width = 160
          r.height = 160
          r.fill = "tomato"
          r.set_clip_path(clip)
        end
      end

      output = svg.to_s
      output.should contain("<defs>")
      output.should contain("<clipPath ")
      output.should contain("id=\"rounded-cut\"")
      output.should contain("<circle ")
      output.should contain("</clipPath>")
      output.should contain("</defs>")
      output.should contain("<rect ")
      output.should contain("clip-path=\"url('#rounded-cut')\"")
      output.should contain("fill=\"tomato\"")
    end

    it "supports clip-rule attribute" do
      svg = Celestine.draw do |ctx|
        ctx.path do |p|
          p.set_clip_path("custom-clip")
          p.clip_rule = "evenodd"
        end
      end

      output = svg.to_s
      output.should contain("clip-path=\"url('#custom-clip')\"")
      output.should contain("clip-rule=\"evenodd\"")
    end
  end

  describe "Style" do
    it "embeds CSS stylesheet with rule helpers" do
      svg = Celestine.draw do |ctx|
        ctx.style do |s|
          s.rule(".brand-icon", fill: "#3b82f6", stroke_width: "2px")
          s.css("circle:hover { fill: #60a5fa; }")
        end
        ctx.circle do |c|
          c.classes << "brand-icon"
          c.cx = 50
          c.cy = 50
          c.radius = 25
        end
      end

      output = svg.to_s
      output.should contain("<style type=\"text/css\">")
      output.should contain(".brand-icon {")
      output.should contain("fill: #3b82f6;")
      output.should contain("stroke-width: 2px;")
      output.should contain("circle:hover { fill: #60a5fa; }")
      output.should contain("</style>")
      output.should contain("class=\"brand-icon\"")
    end
  end

  describe "TSpan and Text Anchor" do
    it "renders text with text-anchor and nested tspans" do
      svg = Celestine.draw do |ctx|
        ctx.text do |t|
          t.x = 100
          t.y = 50
          t.text_anchor = "middle"
          t.dominant_baseline = "central"
          t.font_family = "Inter, sans-serif"

          t.tspan("Hello ") do |s|
            s.fill = "#64748b"
          end

          t.tspan("Celestine") do |s|
            s.fill = "#0284c7"
            s.font_weight = "bold"
            s.dx = 5
          end
        end
      end

      output = svg.to_s
      output.should contain("<text ")
      output.should contain("text-anchor=\"middle\"")
      output.should contain("dominant-baseline=\"central\"")
      output.should contain("<tspan ")
      output.should contain("fill=\"#64748b\"")
      output.should contain(">Hello </tspan>")
      output.should contain("fill=\"#0284c7\"")
      output.should contain("font-weight=\"bold\"")
      output.should contain("dx=\"5\"")
      output.should contain(">Celestine</tspan>")
      output.should contain("</text>")
    end
  end
end
