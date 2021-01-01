# Gives drawables access to the animate DSL
module Celestine::Modules::Animate
  module Attrs
  end

  # Adds a `Celestine::Animate` to the calling drawable's inner elements.
  def animate(&block : Proc(Celestine::Animate, Nil))
    animate = yield Celestine::Animate.new
    animate.draw(inner_elements)
    animate
  end
end
