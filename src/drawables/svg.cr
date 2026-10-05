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

  def view_box(x : IFNumber, y : IFNumber, w : IFNumber, h : IFNumber)
    @view_box = {x: x, y: y, w: w, h: h}
  end

  def view_box=(str : String)
    parts = str.split(/\s+/).reject(&.empty?)
    if parts.size == 4
      x = parts[0].includes?('.') ? parts[0].to_f64 : parts[0].to_i32
      y = parts[1].includes?('.') ? parts[1].to_f64 : parts[1].to_i32
      w = parts[2].includes?('.') ? parts[2].to_f64 : parts[2].to_i32
      h = parts[3].includes?('.') ? parts[3].to_f64 : parts[3].to_i32
      @view_box = {x: x.as(IFNumber), y: y.as(IFNumber), w: w.as(IFNumber), h: h.as(IFNumber)}
    end
  end

  def initialize
  end

  # Draws this SVG root to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    io << %Q[xmlns="http://www.w3.org/2000/svg" ]

    if vb = view_box
      io << %Q[viewBox="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}" ]
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
