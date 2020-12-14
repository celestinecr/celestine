# Draws and holds information for SVG images
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg)
class Celestine::Svg < Celestine::Drawable
  TAG = "svg"

  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  @defines_io = IO::Memory.new

  property view_box : Celestine::ViewBox?
  property shape_rendering : String?

  def initialize
  end

  # Draws this rectangle to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    io << %Q[xmlns="http://www.w3.org/2000/svg" ]

    if vb = view_box
      io << %Q[viewBox="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}" ]
    end

    if self.shape_rendering
      io << %Q[shape-rendering="#{shape_rendering}" ]
    end

    draw_attributes(io)

    
    if !@defines_io.empty? || !inner_elements.empty?
      io << %Q[>]
      if !@defines_io.empty?
        io << %Q[<defs>]
        io << @defines_io
        io << %Q[</defs>]
      end
      io << inner_elements
      io << %Q[</#{TAG}>]
    else
      io << %Q[/>]
    end
  end

  module Attrs
  end
end