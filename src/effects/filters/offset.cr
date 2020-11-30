# Moves the output to another location
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feOffset)
class Celestine::Filter::Offset < Celestine::Filter::Basic
  TAG = "feOffset"

  # The first input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String?
# How much to offset on the x-axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dx)
  make_units dx

  # How much to offset on the y-axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/dy)
  make_units dy

  # Draws this offset filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


    io << %Q[in="#{input}" ] if input
    io << %Q[result="#{result}" ] if result
    io << %Q[dx="#{dx}#{dx_units}" ] if dx
    io << %Q[dy="#{dy}#{dy_units}" ] if dy


    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    DX = "dx"
    DY = "dy"
  end
end