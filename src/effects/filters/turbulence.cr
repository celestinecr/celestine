# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feTurbulence
class Celestine::Filter::Turbulence < Celestine::Filter::Basic
  TAG = "feTurbulence"
  
  property base_freq : IFNumber?
  property num_octaves : IFNumber?
  property seed : IFNumber?
  property type : String?
  property stitch_tiles : String?

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    body_attribute(io)
    
    style_attribute(io)

    io << %Q[result="#{result}" ] if result

    io << %Q[baseFrequency="#{base_freq}" ] if base_freq
    io << %Q[numOctaves="#{num_octaves}" ] if num_octaves
    io << %Q[seed="#{seed}" ] if seed
    io << %Q[type="#{type}" ] if type
    io << %Q[stitchTiles="#{stitch_tiles}" ] if stitch_tiles

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