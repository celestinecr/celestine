class Celestine::Filter::Composite < Celestine::Filter::Basic
  TAG = "feComposite"
  
  property input : String? = nil
  property input2 : String? = nil
  property operator : String? = nil
  property k1 : IFNumber? = nil
  property k2 : IFNumber? = nil
  property k3 : IFNumber? = nil
  property k4 : IFNumber? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    transform_attribute(io)
    body_attribute(io)
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