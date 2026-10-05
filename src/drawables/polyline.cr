# Draws and holds information for polylines
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/polyline)
class Celestine::Polyline < Celestine::Drawable
  TAG = "polyline"

  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Marker

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  property points_raw : String? = nil
  getter points = [] of (Celestine::Point | Celestine::FPoint | Tuple(IFNumber, IFNumber))

  def add_point(x : IFNumber, y : IFNumber)
    @points << {x, y}
  end

  def add_point(pt : Celestine::Point | Celestine::FPoint)
    @points << pt
  end

  def points=(str : String)
    @points_raw = str
  end

  def points_string : String
    if raw = @points_raw
      return raw
    end
    @points.map do |pt|
      case pt
      when Tuple(IFNumber, IFNumber)
        "#{pt[0]},#{pt[1]}"
      else
        "#{pt.x},#{pt.y}"
      end
    end.join(" ")
  end

  # Draws this polyline to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    pts = points_string
    io << %Q[points="#{pts}" ] unless pts.empty?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    POINTS = "points"
  end
end
