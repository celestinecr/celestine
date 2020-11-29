class Celestine::Filter::ColorMatrix < Celestine::Filter::Basic
  TAG = "feColorMatrix"
  property input : String? = nil
  property type : String? = nil
  property values : Array(IFNumber) = [] of IFNumber
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    transform_attribute(io)
    body_attribute(io)
    io << %Q[in="#{input}" ] if input
    io << %Q[type="#{type}" ] if type
    io << %Q[result="#{result}" ] if result
    unless values.empty?
      io << %Q[values="] 
      if values.size == 20
        20.times do |x|
          io << values[x]
          if x != 0 && x != 20 && x % 5 == 0
            io << ","
          else
            io << " "
          end          
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