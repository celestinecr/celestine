struct Celestine::Text < Celestine::Drawable 
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Position
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Animate::Transform

  property text : String = ""

  property dx : SIFNumber?
  property dy : SIFNumber?

  property rotate : SIFNumber?
  property length : SIFNumber?
  property length_adjust : SIFNumber?

  def draw(io : IO) : Nil
    io << %Q[<text ]
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io)
    custom_attribute(io)

    io << %Q[dx="#{dx}" ]                               if dx
    io << %Q[dy="#{dy}" ]                               if dy
    io << %Q[rotate="#{rotate}" ]                       if rotate
    io << %Q[textLength="#{length}" ]                   if length
    io << %Q[lengthAdjust="#{length_adjust}" ]          if length_adjust

    inner_elements << text unless text.empty?
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</text>"
    end
  end

  module Attrs
    DX = "dx"
    DY = "dy"
    ROTATE = "rotate"
    LENGTH = "textLength"
    LENGTH_ADJUST = "lengthAdjust"
  end
end