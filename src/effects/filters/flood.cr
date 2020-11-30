# Composites two filter sources
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feFlood)
class Celestine::Filter::Flood < Celestine::Filter::Basic
  TAG = "feFlood"
  
  # The color of the flood fill
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/flood-color)
  # TODO: Change this to `color`
  property flood_color : String?

  # The opacity of the flood fill
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/flood-opacity)
  # TODO: Change this to `opacity`
  property flood_opacity : IFNumber?

  # Draws this flood filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

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