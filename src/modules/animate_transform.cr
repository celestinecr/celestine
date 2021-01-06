# Gives drawables access to the animate_transform DSL
module Celestine::Modules::Animate::Transform
  ANIMATE_TRANSFORM_TYPES = ["rotate", "translate", "scale", "skewX", "skewY"]

  # Adds a `Celestine::Animate::Transform` to the calling drawable's inner elements.
  def animate_transform_rotate(&block : Proc(Celestine::Animate::Transform::Rotate, Nil))
    animate = yield Celestine::Animate::Transform::Rotate.new
    animate.draw(inner_elements)
    animate
  end

  def animate_transform_translate(&block : Proc(Celestine::Animate::Transform::Translate, Nil))
    animate = yield Celestine::Animate::Transform::Translate.new
    animate.draw(inner_elements)
    animate
  end

  def animate_transform_scale(&block : Proc(Celestine::Animate::Transform::Scale, Nil))
    animate = yield Celestine::Animate::Transform::Scale.new
    animate.draw(inner_elements)
    animate
  end

  def animate_transform_skew_x(&block : Proc(Celestine::Animate::Transform::SkewX, Nil))
    animate = yield Celestine::Animate::Transform::SkewX.new
    animate.draw(inner_elements)
    animate
  end

  def animate_transform_skew_y(&block : Proc(Celestine::Animate::Transform::SkewY, Nil))
    animate = yield Celestine::Animate::Transform::SkewY.new
    animate.draw(inner_elements)
    animate
  end

  def animate_transform_scale(&block : Proc(Celestine::Animate::Transform::Scale, Nil))
    animate = yield Celestine::Animate::Transform::Scale.new
    animate.draw(inner_elements)
    animate
  end
end
