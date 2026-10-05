require "./spec_helper"

describe "Celestine::Color & Palettes" do
  describe "Parsing & Conversions" do
    it "parses 3-digit and 6-digit hex colors" do
      c1 = Celestine::Color.hex("#f00")
      c1.r.should eq(255)
      c1.g.should eq(0)
      c1.b.should eq(0)
      c1.to_hex.should eq("#ff0000")

      c2 = Celestine::Color.hex("#3b82f6")
      c2.r.should eq(59)
      c2.g.should eq(130)
      c2.b.should eq(246)
      c2.to_hex.should eq("#3b82f6")
    end

    it "parses 4-digit and 8-digit hex colors with alpha" do
      c1 = Celestine::Color.hex("#ff000080")
      c1.r.should eq(255)
      c1.a.should be_close(0.501, 0.01)
      c1.to_rgba.should contain("rgba(255, 0, 0,")
    end

    it "constructs from HSL" do
      red = Celestine::Color.hsl(0, 1.0, 0.5)
      red.r.should eq(255)
      red.g.should eq(0)
      red.b.should eq(0)

      green = Celestine::Color.hsl(120, 100, 50)
      green.r.should eq(0)
      green.g.should eq(255)
      green.b.should eq(0)
    end
  end

  describe "Color Manipulations" do
    it "lightens and darkens colors" do
      c = Celestine::Color.hex("#000000")
      lighter = c.lighten(0.5)
      lighter.to_hex.should eq("#808080")

      darker = lighter.darken(0.5)
      darker.to_hex.should eq("#000000")
    end

    it "computes complementary colors" do
      blue = Celestine::Color.hsl(240, 1.0, 0.5)
      yellow = blue.complementary
      h, _, _ = yellow.to_hsl
      h.should be_close(60.0, 1.0)
    end

    it "mixes two colors" do
      black = Celestine::Color.rgb(0, 0, 0)
      white = Celestine::Color.rgb(255, 255, 255)
      gray = black.mix(white, 0.5)
      gray.r.should eq(128)
      gray.g.should eq(128)
      gray.b.should eq(128)
    end
  end

  describe "Palettes" do
    it "provides Nord palette colors" do
      Celestine::Palette::Nord::Frost1.to_hex.should eq("#88c0d0")
      Celestine::Palette::Nord::PolarNight0.to_hex.should eq("#2e3440")
      Celestine::Palette::Nord::Red.to_hex.should eq("#bf616a")
    end

    it "provides Dracula palette colors" do
      Celestine::Palette::Dracula::Background.to_hex.should eq("#282a36")
      Celestine::Palette::Dracula::Cyan.to_hex.should eq("#8be9fd")
      Celestine::Palette::Dracula::Green.to_hex.should eq("#50fa7b")
    end

    it "provides Tailwind palette scales" do
      Celestine::Palette::Tailwind::Slate[500].to_hex.should eq("#64748b")
      Celestine::Palette::Tailwind::Emerald[600].to_hex.should eq("#059669")
      Celestine::Palette::Tailwind::Indigo[500].to_hex.should eq("#6366f1")
    end
  end

  describe "Integration with Celestine DSL" do
    it "assigns Color directly to fill and stroke" do
      svg = Celestine.draw do |ctx|
        ctx.circle do |c|
          c.cx = 50
          c.cy = 50
          c.r = 25
          c.fill = Celestine::Palette::Nord::Frost1
          c.stroke = Celestine::Palette::Nord::PolarNight0
        end
      end

      output = svg.to_s
      output.should contain("fill=\"#88c0d0\"")
      output.should contain("stroke=\"#2e3440\"")
    end
  end
end
