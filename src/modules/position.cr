module Celestine::Modules::Position
  property x : SIFNumber = 0
  property y : SIFNumber = 0

  def position_attribute(io : IO)
    if x != 0 && y != 0
      io << %Q[x="#{x}" y="#{y}" ] 
    elsif x != 0
      io << %Q[x="#{x}" ]
    elsif y != 0
      io << %Q[y="#{y}" ]
    end
  end

  module Attrs
    X = "x"
    Y = "y"
  end
end

module Celestine::Modules::CPosition
  property x : SIFNumber = 0
  property y : SIFNumber = 0

  def position_attribute(io : IO)
    if x != 0 && y != 0
      io << %Q[cx="#{x}" cy="#{y}" ]
    elsif x != 0
      io << %Q[cx="#{x}" ]
    elsif y != 0
      io << %Q[cy="#{y}" ]
    end
  end
  
  module Attrs
    X = "cx"
    Y = "cy"
  end
end