class Celestine::Animate::Transform::Scale < Celestine::Drawable
  TAG = "animateTransform"
  include_options Celestine::Modules::CommonAnimate

  # TODO: Can I use these with units?
  property? use_from = false
  property? use_to = false
  property? use_by = false

  property from_x : Float64? = nil
  property to_x : Float64? = nil
  property by_x : Float64? = nil

  property from_y : Float64? = nil
  property to_y : Float64? = nil
  property by_y : Float64? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Punctuate attributes with a space
    draw_attributes(io)

    io << %Q[attributeName="transform" ]
    io << %Q[type="scale" ]
    io << %Q[from="#{from_x} #{from_y}" ] if use_from?
    io << %Q[to="#{to_x} #{to_y}" ] if use_to?
    io << %Q[by="#{by_x} #{by_y}" ] if use_by?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
