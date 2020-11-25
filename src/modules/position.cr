module Celestine::Modules::Position
  property x : SIFNumber? = nil
  property y : SIFNumber? = nil

  def position_attribute(io : IO)
    io << %Q[x="#{x}" ] if x
    io << %Q[y="#{y}" ] if y
  end

  module Attrs
    X = "x"
    Y = "y"
  end
end

module Celestine::Modules::CPosition
  property x : SIFNumber? = nil
  property y : SIFNumber? = nil

  def position_attribute(io : IO)
   
    io << %Q[cx="#{x}" ] if x
    io << %Q[cy="#{y}" ] if y
  end
  
  module Attrs
    X = "cx"
    Y = "cy"
  end
end