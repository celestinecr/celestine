# Draws and holds information for SVG <symbol> elements
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/symbol)
class Celestine::Symbol < Celestine::Drawable
  TAG = "symbol"

  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Clip

  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  property view_box : Celestine::ViewBox?
  property preserve_aspect_ratio : String?

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

  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)

    if vb = view_box
      io << %Q[viewBox="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}" ]
    end
    if par = preserve_aspect_ratio
      io << %Q[preserveAspectRatio="#{par}" ]
    end

    if !has_inner_elements?
      io << "/>"
    else
      io << '>'
      io << inner_elements
      io << "</" << TAG << '>'
    end
  end
end
