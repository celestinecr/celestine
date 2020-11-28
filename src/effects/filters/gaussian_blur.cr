class Celestine::Filter::Blur < Celestine::Drawable
  include_options Celestine::Modules::Animate

  property input : String? = nil
  property standard_deviation : Float64? = nil
  property standard_deviation_units : String? = nil
  property edge_mode : String? = nil

  def draw(io : IO) : Nil
    io << %Q[<feGaussianBlur ]
    class_attribute(io)
    id_attribute(io)
    io << %Q[in="#{input}" ] if input
    io << %Q[stdDeviation="#{standard_deviation}#{standard_deviation_units}" ] if standard_deviation
    io << %Q[edgeMode="#{edge_mode}" ] if edge_mode

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</feGaussianBlur>"
    end
  end

  module Attrs
    STANDARD_DEVIATION = "stdDeviation"
    EDGE_MODE = "edgeMode"
  end
end