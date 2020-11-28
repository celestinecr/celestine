class Celestine::Animate < Celestine::Drawable
  include_options Celestine::Modules::Animate

  property attribute : String?  = nil
  property repeat_count : IFNumber | String? = nil
  property duration : Float64? = nil
  property values = [] of Float64
  property from : Float64? = nil
  property to : Float64? = nil
  property by : Float64? = nil

  property key_times = [] of Float64
  property key_splines = [] of Float64

  property min : Float64? = nil
  property max : Float64? = nil

  property repeat_duration : Float64? = nil

  property? accumulate = false
  property? additive = false

  property? freeze = false

  def draw(io : IO) : Nil
    io << %Q[<animate ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    io << %Q[attributeName="#{attribute}" ]
    io << %Q[attributeType="XML" ]
    io << %Q[repeatCount="#{repeat_count}" ]         if repeat_count
    io << %Q[repeatDur="#{repeat_duration}" ]        if repeat_duration
    io << %Q[dur="#{duration}" ]                     if duration
    unless values.empty?
      io << %Q[values="]
      values.join(io, ";")
      io << %Q[" ] 
    end
    io << %Q[from="#{from}" ]                        if from
    io << %Q[to="#{to}" ]                           if to
    io << %Q[by="#{by}" ]                           if by

    unless key_times.empty?
      io << %Q[keyTimes="]
      key_times.join(io, ";")
      io << %Q[" ] 
    end

    unless key_splines.empty?
      io << %Q[keySplines="]
      key_splines.join(io, ";")
      io << %Q[" ] 
    end

    io << %Q[min="#{min }" ]                         if min
    io << %Q[min="#{max }" ]                         if max
    io << %Q[accumulate="sum" ]                              if accumulate?
    io << %Q[additive="sum" ]                                if additive?
    io << %Q[fill="freeze" ]                                 if freeze?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</animate>"
    end

  end
end