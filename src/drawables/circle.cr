class Celestine::Circle < Celestine::Drawable
  include_options Celestine::Modules::CPosition
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform
  
  property radius : SIFNumber? = nil

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
    filter_attribute(io) 
    custom_attribute(io)

    io << %Q[r="#{radius}" ] if radius
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