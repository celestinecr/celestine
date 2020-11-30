# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feTile
class Celestine::Filter::Tile < Celestine::Filter::Basic
  TAG = "feTile"
  property input : String? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    
    style_attribute(io)

    io << %Q[in="#{input}" ] if input
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
  end
end