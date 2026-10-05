# Draws and holds information for SVG <tspan> elements within text
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/tspan)
class Celestine::TSpan < Celestine::Drawable
  TAG = "tspan"

  include_options Celestine::Modules::Position
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Clip

  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # The text content to display inside this span
  property text : String? = nil

  make_units dx
  make_units dy

  property rotate : Array(Float64) = [] of Float64
  make_units length
  property length_adjust : String?
  property font_family : String?
  make_units font_size
  property font_size_adjust : Float64?
  property font_stretch : String?
  property font_style : String?
  property font_variant : String?
  property font_weight : String?
  make_units letter_spacing
  property dominant_baseline : String?
  property text_anchor : String?

  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)

    io << %Q[dominant-baseline="#{dominant_baseline}" ] if dominant_baseline
    io << %Q[text-anchor="#{text_anchor}" ] if text_anchor
    io << %Q[dx="#{dx}#{dx_units}" ] if dx
    io << %Q[dy="#{dy}#{dy_units}" ] if dy
    unless rotate.empty?
      io << %Q[rotate="]
      rotate.join(io, " ")
      io << %Q[" ]
    end
    io << %Q[textLength="#{length}#{length_units}" ] if length
    io << %Q[lengthAdjust="#{length_adjust}" ] if length_adjust
    io << %Q[font-family="#{font_family}" ] if font_family
    io << %Q[font-size="#{font_size}#{font_size_units}" ] if font_size
    io << %Q[font-size-adjust="#{font_size_adjust}" ] if font_size_adjust
    io << %Q[font-stretch="#{font_stretch}" ] if font_stretch
    io << %Q[font-style="#{font_style}" ] if font_style
    io << %Q[font-variant="#{font_variant}" ] if font_variant
    io << %Q[font-weight="#{font_weight}" ] if font_weight
    io << %Q[letter-spacing="#{letter_spacing}#{letter_spacing_units}" ] if letter_spacing

    inner_elements << text if text
    if !has_inner_elements?
      io << "/>"
    else
      io << '>'
      io << inner_elements
      io << "</" << TAG << '>'
    end
  end
end
