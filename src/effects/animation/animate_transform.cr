class Celestine::Animate::Transform < Celestine::Drawable
  property type : String?  = nil
  property repeat_count : Float64? = nil
  property duration : Float64? = nil
  # TODO: Check if incoming unit is s ms or h.
  property duration_units : Float64? = nil

  property values = [] of Float64
  #TODO: Can I use these with units?
  property from : Float64? = nil
  property to : Float64? = nil
  property by : Float64? = nil

  property repeat_duration : Float64? = nil

  def draw(io : IO) : Nil
    io << %Q[<animateTransform ]
    # Puncuate attributes with a space 
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    io << %Q[attributeName="transform" ]
    io << %Q[attributeType="XML" ]
    io << %Q[type="#{type}" ]                        if type
    io << %Q[repeatCount="#{repeat_count}" ]         if repeat_count
    io << %Q[repeatDur="#{repeat_duration}" ]        if repeat_duration
    io << %Q[dur="#{duration}#{duration_units}" ]                     if duration
    io << %Q[from="#{from}" ]                        if from
    io << %Q[to="#{to}" ]                            if to
    io << %Q[by="#{by}" ]                            if by

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</animateTransform>"
    end

  end
end