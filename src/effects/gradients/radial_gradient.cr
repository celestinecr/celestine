class Celestine::Gradient::Radial < Celestine::Gradient
  TAG = "radialGradient"

  include_options Celestine::Modules::CPosition

  make_units start_radius
  make_units start_x
  make_units start_y
  make_units radius

  # SVG attribute aliases
  def cx; x; end
  def cx=(val); self.x = val; end
  def cx_units; x_units; end
  def cx_units=(val); self.x_units = val; end

  def cy; y; end
  def cy=(val); self.y = val; end
  def cy_units; y_units; end
  def cy_units=(val); self.y_units = val; end

  def fx; start_x; end
  def fx=(val); self.start_x = val; end
  def fx_units; start_x_units; end
  def fx_units=(val); self.start_x_units = val; end

  def fy; start_y; end
  def fy=(val); self.start_y = val; end
  def fy_units; start_y_units; end
  def fy_units=(val); self.start_y_units = val; end

  def r; radius; end
  def r=(val); self.radius = val; end
  def r_units; radius_units; end
  def r_units=(val); self.radius_units = val; end

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
