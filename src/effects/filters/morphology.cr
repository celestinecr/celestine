class Celestine::Filter::Morphology < Celestine::Drawable
  TAG = "feMorphology"
  include_options Celestine::Modules::Animate

  property input : String? = nil

  make_units radius
  property operator : String?

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    io << %Q[in="#{input}" ] if input
    io << %Q[radius="#{radius}#{radius_units}" ] if radius
    io << %Q[operator="#{operator}" ] if operator


    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    RADIUS = "radius"
    OPERATOR = "operator"
  end
end