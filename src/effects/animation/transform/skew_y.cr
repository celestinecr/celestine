class Celestine::Animate::Transform::SkewY < Celestine::Drawable
  module Attrs
    TYPE = "type"
    ATTRIBUTE_NAME = "attributeName"
    FROM = "from"
    TO = "to"
    BY = "by"
  end

  TYPE = "skewY"
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

    io << %Q[#{Attrs::ATTRIBUTE_NAME}="transform" ]
    io << %Q[#{Attrs::TYPE}="#{TYPE}" ]
    io << %Q[#{Attrs::FROM}="#{from}" ] if use_from?
    io << %Q[#{Attrs::TO}="#{to}" ] if use_to?
    io << %Q[#{Attrs::BY}="#{by}" ] if use_by?

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
