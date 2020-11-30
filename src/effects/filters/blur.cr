# Gaussian blurs a source
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feGaussianBlur)
class Celestine::Filter::Blur < Celestine::Filter::Basic
  TAG = "feGaussianBlur"

  # The input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil
  # The amount of blurring that should occur
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stdDeviation)
  make_units standard_deviation
  
  # How the filter should extend its image size to allow the duplication or wrapping of edge values.
  # 
  # * Potential Values: `duplicate | wrap | none`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/edgeMode)
  property edge_mode : String? = nil

  # Draws this blur filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


    io << %Q[in="#{input}" ] if input
    io << %Q[result="#{result}" ] if result
    io << %Q[stdDeviation="#{standard_deviation}#{standard_deviation_units}" ] if standard_deviation
    io << %Q[edgeMode="#{edge_mode}" ] if edge_mode

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    STANDARD_DEVIATION = "stdDeviation"
    EDGE_MODE = "edgeMode"
  end
end