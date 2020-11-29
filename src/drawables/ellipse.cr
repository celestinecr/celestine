class Celestine::Ellipse < Celestine::Drawable 
  TAG = "ellipse"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::CPosition
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Marker


  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform
  
  make_units :radius_x
  make_units :radius_y


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
    marker_attribute(io)
    custom_attribute(io)

    io << %Q[rx="#{radius_x}#{radius_x_units}" ] if radius_x
    io << %Q[ry="#{radius_y}#{radius_y_units}" ] if radius_y
    
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    RADIUS_X = "rx"
    RADIUS_Y = "ry"
  end
end