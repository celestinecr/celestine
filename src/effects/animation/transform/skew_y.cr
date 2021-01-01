class Celestine::Animate::Transform::SkewY < Celestine::Drawable
  TAG = "animateTransform"
  include_options Celestine::Modules::CommonAnimate

  # TODO: Can I use these with units?
  property? use_from = false
  property? use_to = false
  property? use_by = false

  property from : Float64? = nil
  property to : Float64? = nil
  property by : Float64? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Punctuate attributes with a space
    draw_attributes(io)

    io << %Q[attributeName="transform" ]
    io << %Q[type="skewY" ]
    io << %Q[from="#{from}" ] if use_from?
    io << %Q[to="#{to}" ] if use_to?
    io << %Q[by="#{by}" ] if use_by?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
