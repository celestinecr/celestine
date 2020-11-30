# Draws and holds information for images
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/image)
class Celestine::Image < Celestine::Drawable
  TAG = "image"

  # TODO: Add these


  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # The URI for the image
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/href)
  property href : String? = nil
  # How the image should be rendered.
  # 
  # * Potential values: `auto | optimizeSpeed | optimizeQuality`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/image-rendering)
  property rendering : String? = nil
  
  # Draws the image to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Puncuate attributes with a space 
    draw_attributes(io)


    io << %Q[href="#{href}" ] if href
    io << %Q[image-rendering="#{rendering}" ] if rendering

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end  