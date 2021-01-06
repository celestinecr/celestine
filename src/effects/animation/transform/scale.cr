class Celestine::Animate::Transform::Scale < Celestine::Drawable
  module Attrs
    TYPE = "type"
    ATTRIBUTE_NAME = "attributeName"
    FROM = "from"
    TO = "to"
    BY = "by"
  end

  TYPE = "scale"
  
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

    io << %Q[#{Attrs::ATTRIBUTE_NAME}="transform" ]
    io << %Q[#{Attrs::TYPE}="#{TYPE}" ]
    io << %Q[#{Attrs::FROM}="#{from_x} #{from_y}" ] if use_from?
    io << %Q[#{Attrs::TO}="#{to_x} #{to_y}" ] if use_to?
    io << %Q[#{Attrs::BY}="#{by_x} #{by_y}" ] if use_by?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
