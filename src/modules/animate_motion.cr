# Gives drawables access to the animate_motion DSL
module Celestine::Modules::Animate::Motion
  # Adds a `Celestine::Animate::Motion` to the calling drawable's inner elements.
  def animate_motion(&block : Celestine::Animate::Motion -> Celestine::Animate::Motion)
    animate = yield Celestine::Animate::Motion.new
    animate.draw(inner_elements)
    animate
  end
end
