# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feImage
class Celestine::Filter::Image < Celestine::Filter::Basic
  TAG = "feImage"
  
  property href : String? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    
    style_attribute(io)
    #TODO: Try href vs xlink:href, xlink seems to be depriciated
    io << %Q[xlink:href="#{href}" ] if href
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