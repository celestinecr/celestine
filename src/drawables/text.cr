# Draws and holds information for text
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/text)
class Celestine::Text < Celestine::Drawable
  TAG = "text"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Position
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # The text to be displayed
  property text : String? = nil

  # Shifts the text position horizontally from a previous text element
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dx)
  make_units dx

  # Shifts the text position vertically from a previous text element
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dy)
  make_units dy

  # An array that allows for the rotation of each individual glyph
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/rotate) *note the docs here do not talk about this usage, only on the main element page mentions this*
  property rotate : Array(Float64) = [] of Float64

  # Changes the length of the text.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/textLength)
  make_units length

  # How the length should be adjusted.
  # 
  # * Potential values: `spacing | spacingAndGlyphs`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/lengthAdjust)
  property length_adjust : String?

  # Changes the font family used.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-family)
  property font_family : String?

  # Changes the font size used.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-size)
  make_units font_size

  # Changes the font size adjustment.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-size-adjust)
  property font_size_adjust : Float64?

  # Changes the font stretch type.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-stretch)
  property font_stretch : String?

  # Changes the font style.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-style)
  property font_style : String?

  # Changes the font variant.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-variant)
  property font_variant : String?

  # Changes the font weight.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-weight)
  property font_weight : String?

  # Changes how far letters are spaced.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/letter-spacing)
  # TODO: Make this `SIFNumber?` since it can have the string value "normal" as well as numbers :(
  make_units letter_spacing

  # Changes where the natural anchor is for the text.
  # 
  # * Potential Values: `auto | text-bottom | alphabetic | ideographic | middle | central | mathematical | hanging | text-top`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dominant-baseline)
  property dominant_baseline : String?
  
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::DOMINANT_BASELINE}="#{dominant_baseline}" ] if dominant_baseline
    io << %Q[#{Attrs::DX}="#{dx}#{dx_units}" ] if dx
    io << %Q[#{Attrs::DY}="#{dy}#{dy_units}" ] if dy
    unless rotate.empty?
      io << %Q[rotate="]
      rotate.join(io, " ")
      io << %Q[" ]
    end
    io << %Q[#{Attrs::LENGTH}="#{length}#{length_units}" ] if length
    io << %Q[#{Attrs::LENGTH_ADJUST}="#{length_adjust}" ] if length_adjust
    io << %Q[#{Attrs::FONT_FAMILY}="#{font_family}" ] if font_family
    io << %Q[#{Attrs::FONT_SIZE}="#{font_size}#{font_size_units}" ] if font_size
    io << %Q[#{Attrs::FONT_SIZE_ADJUST}="#{font_size_adjust}" ] if font_size_adjust
    io << %Q[#{Attrs::FONT_STRETCH}="#{font_stretch}" ] if font_stretch
    io << %Q[#{Attrs::FONT_STYLE}="#{font_style}" ] if font_style
    io << %Q[#{Attrs::FONT_VARIANT}="#{font_variant}" ] if font_variant
    io << %Q[#{Attrs::FONT_WEIGHT}="#{font_weight}" ] if font_weight
    io << %Q[#{Attrs::LETTER_SPACING}="#{letter_spacing}#{letter_spacing_units}" ] if letter_spacing


    inner_elements << text if text
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    DX                = "dx"
    DY                = "dy"
    ROTATE            = "rotate"
    LENGTH            = "textLength"
    LENGTH_ADJUST     = "lengthAdjust"
    FONT_FAMILY       = "font-family"
    FONT_SIZE         = "font-size"
    FONT_SIZE_ADJUST  = "font-size-adjust"
    FONT_STRETCH      = "font-stretch"
    FONT_STYLE        = "font-style"
    FONT_VARIANT      = "font-variant"
    FONT_WEIGHT       = "font-weight"
    LETTER_SPACING    = "letter-spacing"
    DOMINANT_BASELINE = "dominant-baseline"
  end
end
