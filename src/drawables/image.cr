class Celestine::Image < Celestine::Drawable
  TAG = "image"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  property url : String? = nil
  
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Puncuate attributes with a space 
    class_attribute(io)
    id_attribute(io)
    position_attribute(io)
    body_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io) 
    filter_attribute(io) 
    custom_attribute(io)

    io << %Q[href="#{url}" ] if url

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end  