# Allows matrix operations on color values
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feColorMatrix)
class Celestine::Filter::ColorMatrix < Celestine::Filter::Basic
  TAG = "feColorMatrix"

  # The input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil

  # The type of operation
  #
  # * Potential Values: `matrix | saturate | hueRotate | luminanceToAlpha`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/type)
  property type : String? = nil

  # The matrix values for the operation
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/values#feColorMatrix)
  property values : Array(IFNumber) = [] of IFNumber

  # Draws this color matrix filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[in="#{input}" ] if input
    io << %Q[type="#{type}" ] if type
    io << %Q[result="#{result}" ] if result
    unless values.empty?
      io << %Q[values="] 
      if values.size == 20
        4.times do |y|
          5.times do |x|
            io << values[x + y * 5]
            io << " " unless x == 4
          end
          io << ", " unless y == 3
        end
      else
        values.join(io, " ")
      end
      io << %Q[" ]

    end

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    INPUT = "in"
    TYPE = "type"
    VALUES = "values"
  end
end