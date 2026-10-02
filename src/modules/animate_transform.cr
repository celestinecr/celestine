# Gives drawables access to the animate_transform DSL
module Celestine::Modules::Animate::Transform
  ANIMATE_TRANSFORM_TYPES = ["rotate", "translate", "scale", "skewX", "skewY"]

  # Adds a `Celestine::Animate::Transform` to the calling drawable's inner elements.
  def animate_transform_rotate(&block : Celestine::Animate::Transform::Rotate ->)
    anim = Celestine::Animate::Transform::Rotate.new
    yield anim
    anim.draw(inner_elements)
    anim
  end

  def animate_transform_translate(&block : Celestine::Animate::Transform::Translate ->)
    anim = Celestine::Animate::Transform::Translate.new
    yield anim
    anim.draw(inner_elements)
    anim
  end

  def animate_transform_scale(&block : Celestine::Animate::Transform::Scale ->)
    anim = Celestine::Animate::Transform::Scale.new
    yield anim
    anim.draw(inner_elements)
    anim
  end

  def animate_transform_skew_x(&block : Celestine::Animate::Transform::SkewX ->)
    anim = Celestine::Animate::Transform::SkewX.new
    yield anim
    anim.draw(inner_elements)
    anim
  end

  def animate_transform_skew_y(&block : Celestine::Animate::Transform::SkewY ->)
    anim = Celestine::Animate::Transform::SkewY.new
    yield anim
    anim.draw(inner_elements)
    anim
  end
end
