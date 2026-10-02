# Gives drawables access to the animate DSL
module Celestine::Modules::Animate
  # Adds a `Celestine::Animate` to the calling drawable's inner elements.
  def animate(&block : Celestine::Animate ->)
    anim = Celestine::Animate.new
    yield anim
    anim.draw(inner_elements)
    anim
  end
end
