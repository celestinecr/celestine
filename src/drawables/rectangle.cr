class Celestine::Rectangle < Celestine::Drawable
  property x : SIFNumber = 0
  property y : SIFNumber = 0
  property width : SIFNumber = 0
  property height : SIFNumber = 0
  property stroke = "none"
  property fill = "none"


  def draw
    %Q[<rect x="#{x}" y="#{y}" width="#{width}" height="#{height}" stroke="#{stroke}" fill="#{fill}" #{transform_options} />]
  end
end