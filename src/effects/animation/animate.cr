class Celestine::Animate < Celestine::Drawable
  module Attrs
    ATTRIBUTE_NAME = "attributeName"
    FROM           = "from"
    TO             = "to"
    BY             = "by"
  end

  TAG = "animate"
  include Celestine::Modules::Animate
  include_options Celestine::Modules::CommonAnimate

  # The attribute that will be controlled by the animation. You can dig into any `Celestine::Drawable`'s `Attrs` module (ex: `Celestine::Circle::Attrs`) and it will contain a
  # list of all attributes the drawable has access to, however, not all attributes are animatable.
  property attribute : String? = nil

  # An optional way to specify what value to start at in the animation.
  make_units from
  # An optional way to specify what value to end at in the animation.
  make_units to

  # An optional way to specify the amount an attribute should change by per frame
  make_units by

  # Support string or number values for from/to/by in animations (e.g. colors, transforms)
  property from_value : SIFNumber? = nil
  property to_value : SIFNumber? = nil
  property by_value : SIFNumber? = nil

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)
    io << %Q[#{Attrs::ATTRIBUTE_NAME}="#{attribute}" ] if attribute
    if val = from_value
      io << %Q[#{Attrs::FROM}="#{val}" ]
    elsif from
      io << %Q[#{Attrs::FROM}="#{from}#{from_units}" ]
    end
    if val = to_value
      io << %Q[#{Attrs::TO}="#{val}" ]
    elsif to
      io << %Q[#{Attrs::TO}="#{to}#{to_units}" ]
    end
    if val = by_value
      io << %Q[#{Attrs::BY}="#{val}" ]
    elsif by
      io << %Q[#{Attrs::BY}="#{by}#{by_units}" ]
    end

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
