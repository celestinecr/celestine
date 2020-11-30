# https://www.smashingmagazine.com/2015/05/why-the-svg-filter-is-awesome/
class Celestine::Filter < Celestine::Drawable
  TAG = "filter"
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::Animate

  property filter_units : String?
  property primitive_units : String?

  SOURCE_GRAPHIC   = "SourceGraphic"
  SOURCE_ALPHA     = "SourceAlpha"
  BACKGROUND_IMAGE = "BackgroundImage" # Doesn't work for some reason :(
  BACKGROUND_ALPHA = "BackgroundAlpha"
  FILL_PAINT       = "FillPaint"
  STROKE_PAINT     = "StrokePaint"

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

  # Adds a `Celestine::Filter::Merge` to the calling filter's inner elements.
  def merge(&block : Celestine::Filter::Merge -> Celestine::Filter::Merge)
    merge_filter = yield Celestine::Filter::Merge.new
    merge_filter.draw(inner_elements)
    merge_filter
  end

  # Adds a `Celestine::Filter::Blend` to the calling filter's inner elements.
  def blend(&block : Celestine::Filter::Blend -> Celestine::Filter::Blend)
    blend_filter = yield Celestine::Filter::Blend.new
    blend_filter.draw(inner_elements)
    blend_filter
  end

  # Adds a `Celestine::Filter::Tile` to the calling filter's inner elements.
  def tile(&block : Celestine::Filter::Tile -> Celestine::Filter::Tile)
    tile_filter = yield Celestine::Filter::Tile.new
    tile_filter.draw(inner_elements)
    tile_filter
  end

  # Adds a `Celestine::Filter::ColorMatrix` to the calling filter's inner elements.
  def color_matrix(&block : Celestine::Filter::ColorMatrix -> Celestine::Filter::ColorMatrix)
    color_matrix_filter = yield Celestine::Filter::ColorMatrix.new
    color_matrix_filter.draw(inner_elements)
    color_matrix_filter
  end

  # Adds a `Celestine::Filter::ComponentTransfer` to the calling filter's inner elements.
  def component_transfer(&block : Celestine::Filter::ComponentTransfer -> Celestine::Filter::ComponentTransfer)
    component_transfer_filter = yield Celestine::Filter::ComponentTransfer.new
    component_transfer_filter.draw(inner_elements)
    component_transfer_filter
  end

  # Adds a `Celestine::Filter::Flood` to the calling filter's inner elements.
  def flood(&block : Celestine::Filter::Flood -> Celestine::Filter::Flood)
    flood_filter = yield Celestine::Filter::Flood.new
    flood_filter.draw(inner_elements)
    flood_filter
  end

  # Adds a `Celestine::Filter::DisplacementMap` to the calling filter's inner elements.
  def displacement_map(&block : Celestine::Filter::DisplacementMap -> Celestine::Filter::DisplacementMap)
    displacement_map_filter = yield Celestine::Filter::DisplacementMap.new
    displacement_map_filter.draw(inner_elements)
    displacement_map_filter
  end

  # Adds a `Celestine::Filter::Turbulence` to the calling filter's inner elements.
  def turbulence(&block : Celestine::Filter::Turbulence -> Celestine::Filter::Turbulence)
    turbulence_filter = yield Celestine::Filter::Turbulence.new
    turbulence_filter.draw(inner_elements)
    turbulence_filter
  end

  # Adds a `Celestine::Filter::Composite` to the calling filter's inner elements.
  def composite(&block : Celestine::Filter::Composite -> Celestine::Filter::Composite)
    composite_filter = yield Celestine::Filter::Composite.new
    composite_filter.draw(inner_elements)
    composite_filter
  end
  

  # Adds a `Celestine::Filter::SpecularLighting` to the calling filter's inner elements.
  def specular_lighting(&block : Celestine::Filter::SpecularLighting -> Celestine::Filter::SpecularLighting)
    specular_lighting_filter = yield Celestine::Filter::SpecularLighting.new
    specular_lighting_filter.draw(inner_elements)
    specular_lighting_filter
  end

    # Adds a `Celestine::Filter::Image` to the calling filter's inner elements.
    def image(&block : Celestine::Filter::Image -> Celestine::Filter::Image)
      image_filter = yield Celestine::Filter::Image.new
      image_filter.draw(inner_elements)
      image_filter
    end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)



    io << %Q[filterUnits="#{filter_units}" ] if filter_units
    io << %Q[primitiveUnits="#{primitive_units}" ] if primitive_units
    
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
