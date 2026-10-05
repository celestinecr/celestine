# Gives drawables access to the animate_motion DSL
module Celestine::Modules::Animate::Motion
  # Adds a `Celestine::Animate::Motion` to the calling drawable's inner elements.
  def animate_motion(&block : Celestine::Animate::Motion ->)
    anim = Celestine::Animate::Motion.new
    yield anim
    anim.draw(inner_elements)
    anim
  end
end
