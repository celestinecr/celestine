# Merges one or mopre filters into a single result
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feTurbulence)
class Celestine::Filter::Turbulence < Celestine::Filter::Basic
  TAG = "feTurbulence"

  # The base frequency parameter for the noise function
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/baseFrequency)
  property base_freq : IFNumber?

  # The number of octaves for the noise function
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/baseFrequency)
  property num_octaves : IFNumber?

  # The seed for the noise function
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/seed)
  property seed : IFNumber?

  # Type of noise function
  # 
  # * Pontential Values: `fractalNoise | turbulence`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/type#feTurbulence)
  property type : String?

  # Defines how the Perlin Noise tiles behave at the border
  # 
  # * Pontential Values: `noStitch | stitch`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stitchTiles)
  property stitch_tiles : String?

  # Draws this turbulence filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


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