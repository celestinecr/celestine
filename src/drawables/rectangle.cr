# Draws and holds information for rectangles
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/rect)
class Celestine::Rectangle < Celestine::Drawable
  TAG = "rect"

  include_options Celestine::Modules::Body
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

  # The corner radius value on the x axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/rx)
  make_units radius_x

  # The corner radius value on the y axis
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/ry)
  make_units radius_y

  # Draws this rectangle to an `IO`
  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)

    if rx = radius_x
      io << Attrs::RADIUS_X << "=\"" << rx << radius_x_units << "\" "
    end
    if ry = radius_y
      io << Attrs::RADIUS_Y << "=\"" << ry << radius_y_units << "\" "
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
    RADIUS_X = "rx"
    RADIUS_Y = "ry"
  end
end
