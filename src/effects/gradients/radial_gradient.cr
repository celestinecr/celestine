class Celestine::Gradient::Radial < Celestine::Gradient
  TAG = "radialGradient"

  include_options Celestine::Modules::CPosition

  make_units start_radius
  make_units start_x
  make_units start_y
  make_units radius

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[gradientUnits="#{gradient_units}" ] if gradient_units
    io << %Q[spreadMethod="#{spread_method}" ] if spread_method
    io << %Q[href="#{href}" ] if href

    io << %Q[fr="#{start_radius}#{start_radius_units}" ] if start_radius
    io << %Q[fx="#{start_x}#{start_x_units}" ] if start_x
    io << %Q[fy="#{start_y}#{start_y_units}" ] if start_y
    io << %Q[r="#{radius}#{radius_units}" ] if radius

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
