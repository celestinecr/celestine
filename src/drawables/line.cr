# Draws and holds information for lines
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/line)
class Celestine::Line < Celestine::Drawable
  TAG = "line"

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

  make_units x1
  make_units y1
  make_units x2
  make_units y2

  # Draws this line to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::X1}="#{x1}#{x1_units}" ] if x1
    io << %Q[#{Attrs::Y1}="#{y1}#{y1_units}" ] if y1
    io << %Q[#{Attrs::X2}="#{x2}#{x2_units}" ] if x2
    io << %Q[#{Attrs::Y2}="#{y2}#{y2_units}" ] if y2

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    X1 = "x1"
    Y1 = "y1"
    X2 = "x2"
    Y2 = "y2"
  end
end
