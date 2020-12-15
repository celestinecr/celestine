class Celestine::Animate::Transform::SkewX < Celestine::Drawable
  TAG = "animateTransform"
  property repeat_count : IFNumber | String? = nil
  make_units duration
  make_units repeat_duration

  #TODO: Can I use these with units?
  property? use_from = false
  property? use_to = false
  property? use_by = false

  property from : Float64? = nil
  property to : Float64? = nil
  property by : Float64? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Puncuate attributes with a space 
    draw_attributes(io)

    io << %Q[attributeName="transform" ]
    io << %Q[attributeType="XML" ]
    io << %Q[type="skewX" ]
    io << %Q[repeatCount="#{repeat_count}" ]                                 if repeat_count
    io << %Q[repeatDur="#{repeat_duration}#{repeat_duration_units}" ]        if repeat_duration
    io << %Q[dur="#{duration}#{duration_units}" ]                            if duration
    io << %Q[from="#{from}" ]                                                if use_from?               
    io << %Q[to="#{to}" ]                                                    if use_to?              
    io << %Q[by="#{by}" ]                                                    if use_by?                   

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end

  end
end
