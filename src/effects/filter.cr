# https://www.smashingmagazine.com/2015/05/why-the-svg-filter-is-awesome/
class Celestine::Filter < Celestine::Drawable
  TAG = "filter"
  include_options Celestine::Modules::Body
  include Celestine::Modules::Animate

  property filter_units : String?
  property primitive_units : String?

  SOURCE_GRAPHIC   = "SourceGraphic"
  SOURCE_ALPHA     = "SourceAlpha"
  BACKGROUND_IMAGE = "BackgroundImage" # Doesn't work for some reason :(
  BACKGROUND_ALPHA = "BackgroundAlpha"
  FILL_PAINT       = "FillPaint"
  STROKE_PAINT     = "StrokePaint"

  # Adds a `Celestine::Filter::Blur` to the calling filter's inner elements.
  def blur(&block : Celestine::Filter::Blur ->)
    filter = Celestine::Filter::Blur.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::DropShadow` to the calling filter's inner elements.
  def drop_shadow(&block : Celestine::Filter::DropShadow ->)
    filter = Celestine::Filter::DropShadow.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Offset` to the calling filter's inner elements.
  def offset(&block : Celestine::Filter::Offset ->)
    filter = Celestine::Filter::Offset.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Morphology` to the calling filter's inner elements.
  def morphology(&block : Celestine::Filter::Morphology ->)
    filter = Celestine::Filter::Morphology.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Merge` to the calling filter's inner elements.
  def merge(&block : Celestine::Filter::Merge ->)
    filter = Celestine::Filter::Merge.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Blend` to the calling filter's inner elements.
  def blend(&block : Celestine::Filter::Blend ->)
    filter = Celestine::Filter::Blend.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Tile` to the calling filter's inner elements.
  def tile(&block : Celestine::Filter::Tile ->)
    filter = Celestine::Filter::Tile.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::ColorMatrix` to the calling filter's inner elements.
  def color_matrix(&block : Celestine::Filter::ColorMatrix ->)
    filter = Celestine::Filter::ColorMatrix.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::ComponentTransfer` to the calling filter's inner elements.
  def component_transfer(&block : Celestine::Filter::ComponentTransfer ->)
    filter = Celestine::Filter::ComponentTransfer.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Flood` to the calling filter's inner elements.
  def flood(&block : Celestine::Filter::Flood ->)
    filter = Celestine::Filter::Flood.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::DisplacementMap` to the calling filter's inner elements.
  def displacement_map(&block : Celestine::Filter::DisplacementMap ->)
    filter = Celestine::Filter::DisplacementMap.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Turbulence` to the calling filter's inner elements.
  def turbulence(&block : Celestine::Filter::Turbulence ->)
    filter = Celestine::Filter::Turbulence.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Composite` to the calling filter's inner elements.
  def composite(&block : Celestine::Filter::Composite ->)
    filter = Celestine::Filter::Composite.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::SpecularLighting` to the calling filter's inner elements.
  def specular_lighting(&block : Celestine::Filter::SpecularLighting ->)
    filter = Celestine::Filter::SpecularLighting.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  # Adds a `Celestine::Filter::Image` to the calling filter's inner elements.
  def image(&block : Celestine::Filter::Image ->)
    filter = Celestine::Filter::Image.new
    yield filter
    filter.draw(inner_elements)
    filter
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::FILTER_UNITS}="#{filter_units}" ] if filter_units
    io << %Q[#{Attrs::PRIMITIVE_UNITS}="#{primitive_units}" ] if primitive_units

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    FILTER_UNITS    = "filterUnits"
    PRIMITIVE_UNITS = "primitiveUnits"
  end
end
