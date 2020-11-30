# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feFlood
class Celestine::Filter::Flood < Celestine::Filter::Basic
  TAG = "feFlood"
  
  property flood_color : String?
  property flood_opacity : IFNumber?

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    
    style_attribute(io)
    io << %Q[result="#{result}" ] if result

    io << %Q[flood-color="#{flood_color}" ] if flood_color
    io << %Q[flood-opacity="#{flood_opacity}" ] if flood_opacity

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    FLOOD_COLOR = "flood-color"
    FLOOD_OPACITY = "flood-opacity"
  end
end