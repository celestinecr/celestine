# Gives drawables access to the animate_motion DSL
module Celestine::Modules::Animate::Motion
  module Attrs
    MPATH = "path"
    ROTATE = "rotate"
    REPEAT_COUNT = "repeatCount"
    REPEAT_DURATION = "repeatDur"
    DURATION = "dur"
    VALUES = "values"
    FROM = "from"
    TO = "to"
    BY = "by"
    KEY_TIMES = "keyTimes"
    KEY_POINTS = "keyPoints"
    KEY_SPLINES = "keySplines"
    MIN = "min"
    MAX = "max"
    ACCUMULATE = "accumulate"
    ADDITIVE = "additive"
    FILL = "fill"
  end

  # Adds a `Celestine::Animate::Motion` to the calling drawable's inner elements.
  def animate_motion(&block : Celestine::Animate::Motion -> Celestine::Animate::Motion)
    animate = yield Celestine::Animate::Motion.new
    animate.draw(inner_elements)
    animate
  end
end