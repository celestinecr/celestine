class Celestine::Filter::DisplacementMap < Celestine::Filter::Basic
  TAG = "feDisplacementMap"
  
  property input : String?
  property input2 : String?
  property scale : IFNumber?
  property x_channel_selector : String?
  property y_channel_selector : String?

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    transform_attribute(io)
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