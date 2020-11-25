class Celestine::Filter < Celestine::Drawable
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Animate


  SOURCE_GRAPHIC = "SourceGraphic"
  SOURCE_ALPHA = "SourceAlpha"
  BACKGROUND_IMAGE = "BackgroundImage" # Doesn't work for some reason :(
  BACKGROUND_ALPHA = "BackgroundAlpha" 
  FILL_PAINT = "FillPaint" 
  STROKE_PAINT = "StrokePaint"

  # Adds a `Celestine::Animate::Motion` to the calling drawable's inner elements.
  def blur(&block : Celestine::Filter::Blur -> Celestine::Filter::Blur)
    blur_filter = yield Celestine::Filter::Blur.new
    blur_filter.draw(inner_elements)
    blur_filter
  end

  def draw(io : IO) : Nil
    io << %Q[<filter ]
    class_attribute(io)
    id_attribute(io)
    body_attribute(io)
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</filter>"
    end
  end
end