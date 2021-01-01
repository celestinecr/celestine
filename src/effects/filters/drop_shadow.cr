# Adds a drop shadow behind the object
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feDropShadow)
class Celestine::Filter::DropShadow < Celestine::Filter::Basic
  TAG = "feDropShadow"

  # The amount of bluring that should occur
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stdDeviation)
  make_units standard_deviation

  # The input source
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil

  # How much to offset on the x-axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dx)
  make_units dx

  # How much to offset on the y-axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dy)
  make_units dy

  # Draws this blend filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)
    io << %Q[#{Attrs::DX}="#{dx}#{dx_units}" ] if dx
    io << %Q[#{Attrs::DY}="#{dy}#{dy_units}" ] if dy

    io << %Q[#{Attrs::INPUT}="#{input}" ] if input
    io << %Q[#{Attrs::RESULT}="#{result}" ] if result
    io << %Q[#{Attrs::STANDARD_DEVIATION}="#{standard_deviation}#{standard_deviation_units}" ] if standard_deviation


    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    DX  = "dx"
    DY = "dy"
    STANDARD_DEVIATION   = "stdDeviation"
    COLOR = "flood-color"
    OPACITY = "flood-opacity"
    INPUT = "in"
  end
end
