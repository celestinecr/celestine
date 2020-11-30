# Creates a source from an image href.
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feImage)
class Celestine::Filter::Image < Celestine::Filter::Basic
  TAG = "feImage"
  
  # The URI of the image
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/href)
  property href : String? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


    # TODO: Try href vs xlink:href, xlink seems to be depriciated but current example on mozilla docs uses it....
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