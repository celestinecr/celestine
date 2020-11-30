# Gives drawables access to the animate_transform DSL
module Celestine::Modules::Animate::Transform
  module Attrs
    ATTRIBUTE_NAME = "attributeName"
    ATTRIBUTE_TYPE = "attributeType"
    ATTRIBUTE_TYPES = ["rotate", "translate", "scale"]
    REPEAT_COUNT = "repeatCount"
    REPEAT_DURATION = "repeatDur"
    DURATION = "dur"
    FROM = "from"
    TO = "to"
    BY = "by"
  end

  # Adds a `Celestine::Animate::Transform` to the calling drawable's inner elements.
  def animate_transform_rotate(&block : Proc(Celestine::Animate::Transform::Rotate, Nil))
    animate = yield Celestine::Animate::Transform::Rotate.new
    animate.draw(inner_elements)
    animate
  end
end