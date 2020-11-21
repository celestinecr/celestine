struct Celestine::Circle < Celestine::Drawable
  include_options Celestine::Modules::CPosition
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask

  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Animate::Transform
  
  property radius : SIFNumber = 0

  def diameter
    radius * 2
  end

  def draw(io : IO) : Nil
    io << %Q[<circle ]
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io) 
    custom_attribute(io)

    io << %Q[r="#{radius}" ]
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</circle>"
    end
  end

  module Attrs
    RADIUS = "r"
  end
end