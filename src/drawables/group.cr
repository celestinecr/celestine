# Draws and holds information for groups
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/g)
class Celestine::Group < Celestine::Drawable
  TAG = "g"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # Draws the group to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    if !inner_elements.empty?
      io << %Q[>]
      io << inner_elements
      io << %Q[</#{TAG}>]
    else
      io << %Q[/>]
    end
  end
end
