# Dilates or erodes it's source.
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feMorphology)
class Celestine::Filter::Morphology < Celestine::Filter::Basic
  TAG = "feMorphology"

  # The first input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil

  # The amount to dilate or erode 
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  make_units radius

  # The amount to dilate or erode 
  # 
  # * Potential Values: `dilate | erode`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/operator#feMorphology)
  property operator : String?

  # Draws this morphology filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


    io << %Q[in="#{input}" ] if input
    io << %Q[result="#{result}" ] if result
    io << %Q[radius="#{radius}#{radius_units}" ] if radius
    io << %Q[operator="#{operator}" ] if operator


    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    RADIUS = "radius"
    OPERATOR = "operator"
  end
end