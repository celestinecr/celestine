class Celestine::Ellipse < Celestine::Drawable 
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::CPosition
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Mask


  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform
  
  property radius_x : SIFNumber = 0
  property radius_y : SIFNumber = 0

  def draw(io : IO) : Nil
    io << %Q[<ellipse ]
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io) 
    custom_attribute(io)

    io << %Q[rx="#{radius_x}" ]
    io << %Q[ry="#{radius_y}" ]
    
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</ellipse>"
    end
  end

  module Attrs
    RADIUS_X = "rx"
    RADIUS_Y = "ry"
  end
end