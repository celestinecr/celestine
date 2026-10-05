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

  property? use_from = false
  property? use_to = false
  property? use_by = false

  property from_x : Float64? = nil
  property to_x : Float64? = nil
  property by_x : Float64? = nil

  property from_y : Float64? = nil
  property to_y : Float64? = nil
  property by_y : Float64? = nil

  property from_str : String? = nil
  property to_str : String? = nil
  property by_str : String? = nil

  def from=(str : String)
    @from_str = str
  end

  def to=(str : String)
    @to_str = str
  end

  def by=(str : String)
    @by_str = str
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::ATTRIBUTE_NAME}="transform" ]
    io << %Q[#{Attrs::TYPE}="#{TYPE}" ]

    if fs = @from_str
      io << %Q[#{Attrs::FROM}="#{fs}" ]
    elsif use_from?
      io << %Q[#{Attrs::FROM}="#{from_x} #{from_y}" ]
    end

    if ts = @to_str
      io << %Q[#{Attrs::TO}="#{ts}" ]
    elsif use_to?
      io << %Q[#{Attrs::TO}="#{to_x} #{to_y}" ]
    end

    if bs = @by_str
      io << %Q[#{Attrs::BY}="#{bs}" ]
    elsif use_by?
      io << %Q[#{Attrs::BY}="#{by_x} #{by_y}" ]
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
