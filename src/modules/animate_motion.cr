module Celestine::Modules::Animate::Motion
  @animate_motion_builder = String::Builder.new
  @animate_motion_tags = ""

  def animate_motion_tags
    @animate_motion_tags = @animate_motion_builder.to_s if @animate_motion_tags.empty?
    @animate_motion_tags
  end

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


  def animate_motion(&block : Celestine::Animate::Motion -> Celestine::Animate::Motion)
    animate = yield Celestine::Animate::Motion.new
    options = [] of String
    unless animate.mpath.empty?
      options << %Q[path="#{animate.mpath}"]
      options << %Q[rotate="#{animate.rotate}"]                    unless animate.rotate == "none"
      options << %Q[repeatCount="#{animate.repeat_count}"]         if animate.repeat_count
      options << %Q[repeatDur="#{animate.repeat_duration}"]        if animate.repeat_duration
      options << %Q[dur="#{animate.duration}"]                     if animate.duration
      options << %Q[values="#{animate.values.join(";")}"]          unless animate.values.empty?
      options << %Q[from="#{animate.from}"]                        if animate.from
      options << %Q[to="#{animate.to}"]                            if animate.to
      options << %Q[by="#{animate.by}"]                            if animate.by
      options << %Q[keyTimes="#{animate.key_times.join(";")}"]     unless animate.key_times.empty?
      options << %Q[keyPoints="#{animate.key_points.join(";")}"]   unless animate.key_points.empty?
      options << %Q[keySplines="#{animate.key_splines.join(";")}"] unless animate.key_splines.empty?
      options << %Q[min="#{animate.min }"]                         if animate.min
      options << %Q[min="#{animate.max }"]                         if animate.max
      options << %Q[accumulate="sum"]                              if animate.accumulate?
      options << %Q[additive="sum"]                                if animate.additive?
      options << %Q[fill="freeze"]                                 if animate.freeze?
      options << animate.custom_options

      if animate.mpath =~ /^#/
        @animate_motion_builder << %Q[<animateMotion #{options.join(" ")}>]
        @animate_motion_builder << %Q[<mpath xlink:href="#{animate.mpath}"/>]
        @animate_motion_builder << %Q[</animateMotion>]
      else
        @animate_motion_builder << %Q[<animateMotion #{options.join(" ")} />]
      end
    end
  end
end