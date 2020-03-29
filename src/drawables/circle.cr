class Celestine::Circle < Celestine::Drawable
  property radius : SIFNumber = 0
  property x : SIFNumber = 0
  property y : SIFNumber = 0
  property stroke = "none"
  property fill = "none"


  def draw
    %Q[<circle cx="#{x}" cy="#{y}" r="#{radius}" stroke="#{stroke}" fill="#{fill}" #{transform_options} />]
  end
end