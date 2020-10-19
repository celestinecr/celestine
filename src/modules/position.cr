module Celestine::Modules::Position
  property x : SIFNumber = 0
  property y : SIFNumber = 0

  def position_options
    if x != 0 && y != 0
      %Q[x="#{x}" y="#{y}"]
    elsif x != 0
      %Q[x="#{x}"]
    elsif y != 0
      %Q[y="#{y}"]
    else
      ""
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

  def position_options
    if x != 0 && y != 0
      %Q[cx="#{x}" cy="#{y}"]
    elsif x != 0
      %Q[cx="#{x}"]
    elsif y != 0
      %Q[cy="#{y}"]
    else
      ""
    end
  end
  
  module Attrs
    X = "cx"
    Y = "cy"
  end
end