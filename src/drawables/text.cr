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

  property text : String? = nil

  make_units dx
  make_units dy

  property rotate : Array(Float64) = [] of Float64

  make_units length
  make_units length_adjust

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-family
  property font_family : String?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-size-adjust
  make_units font_size

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-size-adjust
  property font_size_adjust : Float64?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-stretch
  property font_stretch : String?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-style
  property font_style : String?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-variant
  property font_variant : String?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/font-weight
  property font_weight : String?

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/letter-spacing
  make_units letter_spacing

  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dominant-baseline
  property dominant_baseline : String?
  
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io)
    filter_attribute(io)
    custom_attribute(io)
    io << %Q[#{Attrs::DOMINANT_BASELINE}="#{dominant_baseline}" ] if dominant_baseline
    io << %Q[#{Attrs::DX}="#{dx}#{dx_units}" ] if dx
    io << %Q[#{Attrs::DY}="#{dy}#{dy_units}" ] if dy
    unless rotate.empty?
      io << %Q[rotate="]
      rotate.join(io, " ")
      io << %Q[" ]
    end
    io << %Q[#{Attrs::LENGTH}="#{length}#{length_units}" ] if length
    io << %Q[#{Attrs::LENGTH_ADJUST}="#{length_adjust}#{length_adjust_units}" ] if length_adjust
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
