# Composites two filter sources
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feComposite)
# * [How it works](http://ssp.impulsetrain.com/porterduff.html)
class Celestine::Filter::Composite < Celestine::Filter::Basic
  TAG = "feComposite"
  
  # The first input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil

  # The second input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in2)
  property input2 : String? = nil

  # The operation to apply
  # 
  # * Potential Values: `over | in | out | atop | xor | lighter | arithmetic`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/operator#feComposite)
  property operator : String? = nil

  # Used with the arithmetic operation.
  #
  # `result = k1*i1*i2 + k2*i1 + k3*i2 + k4`
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/k1)
  property k1 : IFNumber? = nil

  # Used with the arithmetic operation.
  #
  # `result = k1*i1*i2 + k2*i1 + k3*i2 + k4`
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/k2)
  property k2 : IFNumber? = nil

  # Used with the arithmetic operation.
  #
  # `result = k1*i1*i2 + k2*i1 + k3*i2 + k4`
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/k3)
  property k3 : IFNumber? = nil

  # Used with the arithmetic operation. 
  #
  # `result = k1*i1*i2 + k2*i1 + k3*i2 + k4`
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/k4)
  property k4 : IFNumber? = nil

  # Draws this composite filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[in="#{input}" ] if input
    io << %Q[in2="#{input2}" ] if input2
    io << %Q[operator="#{operator}" ] if operator
    io << %Q[k1="#{k1}" ] if k1
    io << %Q[k2="#{k2}" ] if k2
    io << %Q[k3="#{k3}" ] if k3
    io << %Q[k4="#{k4}" ] if k4


    io << %Q[result="#{result}" ] if result

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
    INPUT2 = "in2"
    OPERATOR = "operator"
  end
end