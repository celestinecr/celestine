class Celestine::Filter::Blend < Celestine::Filter::Basic
  TAG = "feBlend"
  
  property input : String? = nil
  property input2 : String? = nil
  property mode : String? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    transform_attribute(io)
    io << %Q[in="#{input}" ] if input
    io << %Q[in2="#{input2}" ] if input2
    io << %Q[mode="#{mode}" ] if mode
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
    MODE = "mode"
  end
end