struct Celestine::Animate < Celestine::Drawable
  include_options Celestine::Modules::Animate

  property attribute : String?  = nil
  property repeat_count : SIFNumber? = nil
  property duration : SIFNumber? = nil
  property values = [] of SIFNumber
  property from : SIFNumber? = nil
  property to : SIFNumber? = nil
  property by : SIFNumber? = nil

  property key_times = [] of SIFNumber
  property key_splines = [] of SIFNumber

  property min : SIFNumber? = nil
  property max : SIFNumber? = nil

  property repeat_duration : SIFNumber? = nil

  property? accumulate = false
  property? additive = false

  property? freeze = false

  def draw(io : IO) : Nil
    io << %Q[<animate ]
    # Puncuate attributes with a space 
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