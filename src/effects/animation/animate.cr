class Celestine::Animate < Celestine::Drawable
  TAG = "animate"
  include_options Celestine::Modules::Animate

  property attribute : String?  = nil
  property repeat_count : IFNumber | String? = nil
  make_units duration
  property values : Array(SIFNumber) = [] of SIFNumber

  make_units from
  make_units to
  make_units by

  property key_times : Array(SIFNumber) = [] of SIFNumber
  property key_splines : Array(SIFNumber) = [] of SIFNumber

  make_units min
  make_units max

  make_units repeat_duration

  property? accumulate = false
  property? additive = false

  property? freeze = false

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[attributeName="#{attribute}" ]
    io << %Q[attributeType="XML" ]
    io << %Q[repeatCount="#{repeat_count}" ]         if repeat_count
    io << %Q[repeatDur="#{repeat_duration}#{duration_units}" ]        if repeat_duration
    io << %Q[dur="#{duration}#{duration_units}" ]                     if duration
    unless values.empty?
      io << %Q[values="]
      values.join(io, ";")
      io << %Q[" ] 
    end
    io << %Q[from="#{from}#{from_units}" ]                        if from
    io << %Q[to="#{to}#{to_units}" ]                           if to
    io << %Q[by="#{by}#{by_units}" ]                           if by

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

    io << %Q[min="#{min}#{min_units}" ]                         if min
    io << %Q[min="#{max}#{max_units}" ]                         if max
    io << %Q[accumulate="sum" ]                              if accumulate?
    io << %Q[additive="sum" ]                                if additive?
    io << %Q[fill="freeze" ]                                 if freeze?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end

  end
end