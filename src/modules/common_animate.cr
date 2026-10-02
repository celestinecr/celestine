# Gives animated elements like `animate` and `animate_motion` it's shared attributes.
module Celestine::Modules::CommonAnimate
  module Attrs
    REPEAT_COUNT    = "repeatCount"
    REPEAT_DURATION = "repeatDur"
    DURATION        = "dur"
    VALUES          = "values"
    KEY_TIMES       = "keyTimes"
    KEY_SPLINES     = "keySplines"
    MIN             = "min"
    MAX             = "max"
    ACCUMULATE      = "accumulate"
    ADDITIVE        = "additive"
    FILL            = "fill"
    CALC_MODE       = "calcMode"
  end

  # TODO: Add begin and end attributes https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/begin https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/end

  # How many times this animation should be repeated. This can be a number or the string `"indefinite"`
  property repeat_count : IFNumber | String? = nil

  # The duration of the animation
  make_units duration

  getter values = [] of SIFNumber
  getter key_times = [] of SIFNumber
  getter key_splines = [] of SIFNumber

  def values=(vals : Enumerable)
    @values = vals.map { |v| v.as(SIFNumber) }.to_a
  end

  def key_times=(vals : Enumerable)
    @key_times = vals.map { |v| v.as(SIFNumber) }.to_a
  end

  def key_splines=(vals : Enumerable)
    @key_splines = vals.map { |v| v.as(SIFNumber) }.to_a
  end

  # Defines how the animation should interpolate values.
  #
  # * Potential values: `discrete | linear | paced | spline`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/calcMode)
  property calc_mode : String? = nil

  # The min attribute specifies the minimum value of the active animation duration
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/min)
  make_units min

  # The max attribute specifies the minimum value of the active animation duration
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/max)
  make_units max

  # The duration that the animation should repeat.
  make_units repeat_duration

  # The accumulate attribute controls whether or not an animation is cumulative.
  # It is frequently useful for repeated animations to build upon the previous results, accumulating with each iteration.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/accumulate)
  property? accumulate = false
  # The additive attribute controls whether or not an animation is additive.
  # It is frequently useful to define animation as an offset or delta to an attribute's value, rather than as absolute values.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/additive)
  property? additive = false
  # The additive attribute controls whether or not an animation is additive.
  # It is frequently useful to define animation as an offset or delta to an attribute's value, rather than as absolute values.
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/freeze)
  property? freeze = false

  def animate_attribute(io : IO)
    io << %Q[#{Attrs::REPEAT_COUNT}="#{repeat_count}" ] if repeat_count
    io << %Q[#{Attrs::REPEAT_DURATION}="#{repeat_duration}#{duration_units}" ] if repeat_duration
    io << %Q[#{Attrs::DURATION}="#{duration}#{duration_units}" ] if duration
    unless values.empty?
      io << %Q[#{Attrs::VALUES}="]
      values.join(io, ";")
      io << %Q[" ]
    end
    unless key_times.empty?
      io << %Q[#{Attrs::KEY_TIMES}="]
      key_times.join(io, ";")
      io << %Q[" ]
    end

    unless key_splines.empty?
      io << %Q[#{Attrs::KEY_SPLINES}="]
      key_splines.join(io, ";")
      io << %Q[" ]
    end

    io << %Q[#{Attrs::MIN}="#{min}#{min_units}" ] if min
    io << %Q[#{Attrs::MAX}="#{max}#{max_units}" ] if max
    io << %Q[#{Attrs::ACCUMULATE}="sum" ] if accumulate?
    io << %Q[#{Attrs::ADDITIVE}="sum" ] if additive?
    io << %Q[#{Attrs::FILL}="freeze" ] if freeze?
    io << %Q[#{Attrs::CALC_MODE}="#{calc_mode}" ] if calc_mode
  end
end
