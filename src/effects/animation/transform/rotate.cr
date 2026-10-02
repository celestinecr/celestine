class Celestine::Animate::Transform::Rotate < Celestine::Drawable
  module Attrs
    TYPE = "type"
    ATTRIBUTE_NAME = "attributeName"
    FROM = "from"
    TO = "to"
    BY = "by"
  end

  TYPE = "rotate"

  TAG = "animateTransform"
  include_options Celestine::Modules::CommonAnimate

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
      io << %Q[#{Attrs::FROM}="#{from_angle} #{from_origin_x} #{from_origin_y}" ]
    end

    if ts = @to_str
      io << %Q[#{Attrs::TO}="#{ts}" ]
    elsif use_to?
      io << %Q[#{Attrs::TO}="#{to_angle} #{to_origin_x} #{to_origin_y}" ]
    end

    if bs = @by_str
      io << %Q[#{Attrs::BY}="#{bs}" ]
    elsif use_by?
      io << %Q[#{Attrs::BY}="#{by_angle} #{by_origin_x} #{by_origin_y}" ]
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
