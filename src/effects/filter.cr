class Celestine::Filter < Celestine::Drawable
  TAG = "filter"
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Animate


  SOURCE_GRAPHIC = "SourceGraphic"
  SOURCE_ALPHA = "SourceAlpha"
  BACKGROUND_IMAGE = "BackgroundImage" # Doesn't work for some reason :(
  BACKGROUND_ALPHA = "BackgroundAlpha" 
  FILL_PAINT = "FillPaint" 
  STROKE_PAINT = "StrokePaint"

  # Adds a `Celestine::Filter::Blur` to the calling filter's inner elements.
  def blur(&block : Celestine::Filter::Blur -> Celestine::Filter::Blur)
    blur_filter = yield Celestine::Filter::Blur.new
    blur_filter.draw(inner_elements)
    blur_filter
  end

  # Adds a `Celestine::Filter::Offset` to the calling filter's inner elements.
  def offset(&block : Celestine::Filter::Offset -> Celestine::Filter::Offset)
    offset_filter = yield Celestine::Filter::Offset.new
    offset_filter.draw(inner_elements)
    offset_filter
  end

  # Adds a `Celestine::Filter::Morphology` to the calling filter's inner elements.
    def morphology(&block : Celestine::Filter::Morphology -> Celestine::Filter::Morphology)
      morphology_filter = yield Celestine::Filter::Morphology.new
      morphology_filter.draw(inner_elements)
      morphology_filter
    end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    body_attribute(io)
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end