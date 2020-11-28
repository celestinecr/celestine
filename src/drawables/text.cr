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
  
  make_units :dx
  make_units :dy

  property rotate : Array(Float64) = [] of Float64

  make_units :length
  make_units :length_adjust



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

    io << %Q[dx="#{dx}#{dx_units}" ]                               if dx
    io << %Q[dy="#{dy}#{dy_units}" ]                               if dy
    unless rotate.empty?
      io << %Q[rotate="]                            
      rotate.join(io, " ")
      io << %Q[" ]
    end
    io << %Q[textLength="#{length}#{length_units}" ]                   if length
    io << %Q[lengthAdjust="#{length_adjust}#{length_adjust_units}" ]          if length_adjust

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
    DX = "dx"
    DY = "dy"
    ROTATE = "rotate"
    LENGTH = "textLength"
    LENGTH_ADJUST = "lengthAdjust"
  end
end