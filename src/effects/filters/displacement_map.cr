# Composites two filter sources
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feDisplacementMap)
class Celestine::Filter::DisplacementMap < Celestine::Filter::Basic
  TAG = "feDisplacementMap"
  
  # The first input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String?
  
  # The second input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in2)
  property input2 : String?

  # Displacement factor to be used
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/scale
  property scale : IFNumber?

  # Seems broken ,couldn't find a working example. Even mozilla's example was busted.
  # 
  # * Potential Values: `R | G | B | A`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/xChannelSelector
  property x_channel_selector : String?

  # Seems broken ,couldn't find a working example. Even mozilla's example was busted.
  # 
  # * Potential Values: `R | G | B | A`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/yChannelSelector
  property y_channel_selector : String?

  # Draws this displacement map to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[result="#{result}" ] if result

    io << %Q[in="#{input}" ] if input
    io << %Q[in2="#{input2}" ] if input2
    io << %Q[scale="#{scale}" ] if scale
    io << %Q[xChannelSelector="#{x_channel_selector}" ] if x_channel_selector
    io << %Q[yChannelSelector="#{y_channel_selector}" ] if y_channel_selector


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
    SCALE = "scale"
    X_CHANNEL_SELECTOR = "xChannelSelector"
    Y_CHANNEL_SELECTOR = "yChannelSelector"
  end
end