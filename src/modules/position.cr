module Celestine::Modules::Position
  property x : Float64? = nil
  property x_units : String? = nil
  property y : Float64? = nil
  property y_units : String? = nil

  def position_attribute(io : IO)
    io << %Q[x="#{x}#{x_units}" ] if x
    io << %Q[y="#{y}#{y_units}" ] if y
  end

  module Attrs
    X = "x"
    Y = "y"
  end
end

module Celestine::Modules::CPosition
  property x : Float64? = nil
  property x_units : String? = nil
  property y : Float64? = nil
  property y_units : String? = nil

  def position_attribute(io : IO)
    io << %Q[cx="#{x}#{x_units}" ] if x
    io << %Q[cy="#{y}#{y_units}" ] if y
  end
  
  module Attrs
    X = "cx"
    Y = "cy"
  end
end