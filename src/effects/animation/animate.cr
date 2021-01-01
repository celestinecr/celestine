class Celestine::Animate < Celestine::Drawable
  module Attrs
    ATTRIBUTE_NAME = "attributeName"
    FROM           = "from"
    TO             = "to"
    BY             = "by"
  end

  TAG = "animate"
  include_options Celestine::Modules::Animate
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

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)
    io << %Q[attributeName="#{attribute}" ]
    io << %Q[from="#{from}#{from_units}" ] if from
    io << %Q[to="#{to}#{to_units}" ] if to
    io << %Q[by="#{by}#{by_units}" ] if by

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
