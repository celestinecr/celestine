module Celestine::Modules::Animate
  module Attrs
    ATTRIBUTE_NAME = "attributeName"
    ATTRIBUTE_TYPE = "attributeType"
    REPEAT_COUNT = "repeatCount"
    REPEAT_DURATION = "repeatDur"
    DURATION = "dur"
    VALUES = "values"
    FROM = "from"
    TO = "to"
    BY = "by"
    KEY_TIMES = "keyTimes"
    KEY_SPLINES = "keySplines"
    MIN = "min"
    MAX = "max"
    ACCUMULATE = "accumulate"
    ADDITIVE = "additive"
    FILL = "fill"
  end


  def animate(&block : Proc(Celestine::Animate, Nil))
    animate = yield Celestine::Animate.new
    animate.draw(inner_elements)
  end
end