class Celestine::Gradient::Linear < Celestine::Gradient
  TAG = "linearGradient"

  make_units x1
  make_units x2
  make_units y1
  make_units y2

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[gradientUnits="#{gradient_units}" ] if gradient_units
    io << %Q[spreadMethod="#{spread_method}" ] if spread_method
    io << %Q[href="#{href}" ] if href
    io << %Q[x1="#{x1}#{x1_units}" ] if x1
    io << %Q[x2="#{x2}#{x2_units}" ] if x2
    io << %Q[y1="#{y1}#{y1_units}" ] if y1
    io << %Q[y2="#{y2}#{y2_units}" ] if y2

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    X1 = "x1"
    X2 = "x2"
    Y1 = "y1"
    Y2 = "y2"
  end
end
