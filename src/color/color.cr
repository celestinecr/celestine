# Represents an RGBA/HSLA color with parsing, conversions, and manipulation utilities.
struct Celestine::Color
  getter r : UInt8
  getter g : UInt8
  getter b : UInt8
  getter a : Float64

  def initialize(r : Number, g : Number, b : Number, a : Number = 1.0)
    @r = r.to_u8.clamp(0_u8, 255_u8)
    @g = g.to_u8.clamp(0_u8, 255_u8)
    @b = b.to_u8.clamp(0_u8, 255_u8)
    @a = a.to_f64.clamp(0.0, 1.0)
  end

  # Creates a color from RGB integers (0-255) and alpha (0.0-1.0)
  def self.rgb(r : Number, g : Number, b : Number, a : Number = 1.0) : Color
    new(r, g, b, a)
  end

  # Parses hex color strings: "#RGB", "#RGBA", "#RRGGBB", or "#RRGGBBAA"
  def self.hex(str : String) : Color
    s = str.lstrip('#')
    case s.size
    when 3
      r = (s[0].to_s * 2).to_u8(16)
      g = (s[1].to_s * 2).to_u8(16)
      b = (s[2].to_s * 2).to_u8(16)
      new(r, g, b, 1.0)
    when 4
      r = (s[0].to_s * 2).to_u8(16)
      g = (s[1].to_s * 2).to_u8(16)
      b = (s[2].to_s * 2).to_u8(16)
      a = (s[3].to_s * 2).to_u8(16) / 255.0
      new(r, g, b, a)
    when 6
      r = s[0..1].to_u8(16)
      g = s[2..3].to_u8(16)
      b = s[4..5].to_u8(16)
      new(r, g, b, 1.0)
    when 8
      r = s[0..1].to_u8(16)
      g = s[2..3].to_u8(16)
      b = s[4..5].to_u8(16)
      a = s[6..7].to_u8(16) / 255.0
      new(r, g, b, a)
    else
      raise ArgumentError.new("Invalid hex color format: #{str}")
    end
  end

  # Creates a color from HSL (h: 0-360, s: 0.0-1.0 or 0-100, l: 0.0-1.0 or 0-100)
  def self.hsl(h : Number, s : Number, l : Number, a : Number = 1.0) : Color
    hue = (h.to_f64 % 360.0 + 360.0) % 360.0
    sat = s.to_f64 > 1.0 ? s.to_f64 / 100.0 : s.to_f64
    lit = l.to_f64 > 1.0 ? l.to_f64 / 100.0 : l.to_f64
    sat = sat.clamp(0.0, 1.0)
    lit = lit.clamp(0.0, 1.0)

    c = (1.0 - (2.0 * lit - 1.0).abs) * sat
    x = c * (1.0 - ((hue / 60.0) % 2.0 - 1.0).abs)
    m = lit - c / 2.0

    r1, g1, b1 = case hue
    when 0.0...60.0    then {c, x, 0.0}
    when 60.0...120.0  then {x, c, 0.0}
    when 120.0...180.0 then {0.0, c, x}
    when 180.0...240.0 then {0.0, x, c}
    when 240.0...300.0 then {x, 0.0, c}
    else                    {c, 0.0, x}
    end

    new(((r1 + m) * 255.0).round.to_u8,
        ((g1 + m) * 255.0).round.to_u8,
        ((b1 + m) * 255.0).round.to_u8,
        a)
  end

  # Converts this color to HSL representation: {hue, saturation, lightness}
  def to_hsl : Tuple(Float64, Float64, Float64)
    r1 = @r.to_f64 / 255.0
    g1 = @g.to_f64 / 255.0
    b1 = @b.to_f64 / 255.0

    max_c = {r1, g1, b1}.max
    min_c = {r1, g1, b1}.min
    delta = max_c - min_c

    l = (max_c + min_c) / 2.0

    if delta < 0.00001
      return {0.0, 0.0, l}
    end

    s = l > 0.5 ? delta / (2.0 - max_c - min_c) : delta / (max_c + min_c)

    h = if max_c == r1
          ((g1 - b1) / delta) + (g1 < b1 ? 6.0 : 0.0)
        elsif max_c == g1
          ((b1 - r1) / delta) + 2.0
        else
          ((r1 - g1) / delta) + 4.0
        end
    h *= 60.0

    {h, s, l}
  end

  # Formats as CSS hex string
  def to_hex(include_alpha : Bool = false) : String
    if include_alpha
      alpha_byte = (@a * 255.0).round.to_u8
      sprintf("#%02x%02x%02x%02x", @r, @g, @b, alpha_byte)
    else
      sprintf("#%02x%02x%02x", @r, @g, @b)
    end
  end

  # Formats as CSS rgb(...) string
  def to_rgb : String
    "rgb(#{@r}, #{@g}, #{@b})"
  end

  # Formats as CSS rgba(...) string
  def to_rgba : String
    a_str = @a == @a.to_i32 ? @a.to_i32.to_s : sprintf("%.2f", @a).rstrip('0').rstrip('.')
    "rgba(#{@r}, #{@g}, #{@b}, #{a_str})"
  end

  # Default string conversion: hex when fully opaque, rgba when translucent
  def to_s(io : IO) : Nil
    if @a < 0.999
      io << to_rgba
    else
      io << to_hex
    end
  end

  def to_s : String
    String.build { |io| to_s(io) }
  end

  # Returns a copy of this color with adjusted alpha
  def with_alpha(new_alpha : Number) : Color
    Color.new(@r, @g, @b, new_alpha)
  end

  # Lightens color by a fraction (0.0 - 1.0)
  def lighten(amount : Number) : Color
    h, s, l = to_hsl
    Color.hsl(h, s, (l + amount.to_f64).clamp(0.0, 1.0), @a)
  end

  # Darkens color by a fraction (0.0 - 1.0)
  def darken(amount : Number) : Color
    h, s, l = to_hsl
    Color.hsl(h, s, (l - amount.to_f64).clamp(0.0, 1.0), @a)
  end

  # Increases saturation by a fraction (0.0 - 1.0)
  def saturate(amount : Number) : Color
    h, s, l = to_hsl
    Color.hsl(h, (s + amount.to_f64).clamp(0.0, 1.0), l, @a)
  end

  # Decreases saturation by a fraction (0.0 - 1.0)
  def desaturate(amount : Number) : Color
    h, s, l = to_hsl
    Color.hsl(h, (s - amount.to_f64).clamp(0.0, 1.0), l, @a)
  end

  # Returns the complementary color (180 degree hue shift)
  def complementary : Color
    h, s, l = to_hsl
    Color.hsl((h + 180.0) % 360.0, s, l, @a)
  end

  # Mixes this color with another color by weight (0.0 = self, 1.0 = other)
  def mix(other : Color, weight : Number = 0.5) : Color
    w = weight.to_f64.clamp(0.0, 1.0)
    w_inv = 1.0 - w

    new_r = (@r.to_f64 * w_inv + other.r.to_f64 * w).round.to_u8
    new_g = (@g.to_f64 * w_inv + other.g.to_f64 * w).round.to_u8
    new_b = (@b.to_f64 * w_inv + other.b.to_f64 * w).round.to_u8
    new_a = @a * w_inv + other.a * w

    Color.new(new_r, new_g, new_b, new_a)
  end
end
