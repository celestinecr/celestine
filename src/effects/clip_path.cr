# Represents an SVG <clipPath> element for clipping vector shapes
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/clipPath)
class Celestine::ClipPath < Celestine::Drawable
  TAG = "clipPath"

  include_options Celestine::Modules::Transform
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # Defines the coordinate system for the clipping path
  # Potential values: `userSpaceOnUse | objectBoundingBox`
  property clip_path_units : String?

  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)
    if cpu = @clip_path_units
      io << %Q[clipPathUnits="#{cpu}" ]
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
