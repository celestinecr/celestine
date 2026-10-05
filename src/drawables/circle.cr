# Draws and holds information for circles
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/circle)
class Celestine::Circle < Celestine::Drawable
  TAG = "circle"

  include_options Celestine::Modules::CPosition
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Clip
  include_options Celestine::Modules::Marker

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # Radius of the circle
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/r)
  make_units :radius

  def r; radius; end
  def r=(val); self.radius = val; end
  def r_units; radius_units; end
  def r_units=(val); self.radius_units = val; end

  # The diameter of the circle
  def diameter
    radius.try { |r| r * 2 }
  end

  # Draws this circle to an `IO`
  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)

    if r = radius
      io << "r=\"" << r << radius_units << "\" "
    end

    if !has_inner_elements?
      io << "/>"
    else
      io << ">"
      io << inner_elements
      io << "</" << TAG << '>'
    end
  end

  module Attrs
    RADIUS = "r"
  end
end
