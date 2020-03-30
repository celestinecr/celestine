module Celestine::Modules::Position
  property x : SIFNumber = 0
  property y : SIFNumber = 0

  def position_options
    if self.is_a?(Celestine::Circle | Celestine::Ellipse)
      %Q[cx="#{x}" cy="#{y}"]
    else
      %Q[x="#{x}" y="#{y}"]
    end
  end
end