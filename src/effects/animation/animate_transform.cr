class Celestine::Animate::Transform < Celestine::Drawable
  property type : String?  = nil
  property repeat_count : SIFNumber? = nil
  property duration : SIFNumber? = nil
  property values = [] of SIFNumber
  property from : SIFNumber? = nil
  property to : SIFNumber? = nil
  property by : SIFNumber? = nil

  property repeat_duration : SIFNumber? = nil

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
    io << %Q[dur="#{duration}" ]                     if duration
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