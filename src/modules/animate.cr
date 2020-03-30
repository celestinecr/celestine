module Celestine::Modules::Animate
  @animate_tags = String::Builder.new

  def animate_tags
    @animate_tags.to_s
  end

  def animate(&block : Proc(Celestine::Animate, Nil))
    animate = Celestine::Animate.new
    yield animate
    options = [] of String
    if animate.attribute
      options << %Q[attributeName="#{animate.attribute}"]
      options << %Q[repeatCount="#{animate.repeat_count}"]         if animate.repeat_count
      options << %Q[repeatDur="#{animate.repeat_duration}"]        if animate.repeat_duration
      options << %Q[dur="#{animate.duration}"]                     if animate.duration
      options << %Q[values="#{animate.values.join(";")}"]          unless animate.values.empty?
      options << %Q[from="#{animate.from}"]                        if animate.from
      options << %Q[to="#{animate.to}"]                            if animate.to
      options << %Q[by="#{animate.by}"]                            if animate.by
      options << %Q[keyTimes="#{animate.key_times.join(";")}"]     unless animate.key_times.empty?
      options << %Q[keySplines="#{animate.key_splines.join(";")}"] unless animate.key_splines.empty?
      options << %Q[min="#{animate.min }"]                         if animate.min
      options << %Q[min="#{animate.max }"]                         if animate.max
      options << %Q[accumulate="sum"]                              if animate.accumulate?
      options << %Q[additive="sum"]                                if animate.additive?
      options << %Q[fill="freeze"]                                 if animate.freeze?

      @animate_tags << %Q[<animate #{options.join(" ")} />]
    end
  end
end