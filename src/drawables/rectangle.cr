class Celestine::Rectangle < Celestine::Drawable
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform
  property radius_x : SIFNumber? = nil

  def draw(io : IO) : Nil
    io << %Q[<rect ]
    class_attribute(io)
    id_attribute(io)
    body_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io)
    custom_attribute(io)

    io << %Q[rx="#{radius_x}" ] if radius_x
    
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</rect>"
    end
  end




  module Attrs
    RADIUS_X = "rx"
  end
end