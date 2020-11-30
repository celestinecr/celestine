class Celestine::Animate::Transform::Rotate < Celestine::Drawable
  TAG = "animateTransform"
  property repeat_count : IFNumber | String? = nil
  make_units duration
  make_units repeat_duration

  #TODO: Can I use these with units?
  property? use_from = false
  property? use_to = false
  property? use_by = false

  property from_angle : Float64? = nil
  property to_angle : Float64? = nil
  property by_angle : Float64? = nil

  property from_origin_x : Float64? = nil
  property to_origin_x : Float64? = nil
  property by_origin_x : Float64? = nil

  property from_origin_y : Float64? = nil
  property to_origin_y : Float64? = nil
  property by_origin_y : Float64? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Puncuate attributes with a space 
    draw_attributes(io)

    io << %Q[attributeName="transform" ]
    io << %Q[attributeType="XML" ]
    io << %Q[type="rotate" ]
    io << %Q[repeatCount="#{repeat_count}" ]                                 if repeat_count
    io << %Q[repeatDur="#{repeat_duration}#{repeat_duration_units}" ]        if repeat_duration
    io << %Q[dur="#{duration}#{duration_units}" ]                            if duration
    io << %Q[from="#{from_angle} #{from_origin_x} #{from_origin_y}" ]        if use_from?               
    io << %Q[to="#{to_angle} #{to_origin_x} #{to_origin_y}" ]                if use_to?              
    io << %Q[by="#{by_angle} #{by_origin_x} #{by_origin_y}" ]                if use_by?                   

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end

  end
end