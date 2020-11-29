module Celestine::Modules::StrokeFill
  property stroke : String?  = nil
  property fill : String? = nil
  make_units stroke_width
  make_field fill_opacity
  make_field stroke_opacity
  property dash_array : Array(Float64) = [] of Float64
  make_units dash_offset

  property line_join : String? = nil
  make_units miter_limit


  property line_cap : String? = nil


  make_field opacity
  property fill_rule : Bool = false

  property color : String? = nil
  property color_interpolation : String? = nil
  property color_interpolation_filters : String? = nil
  # https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/shape-rendering
  property shape_rendering : String? = nil

  
  def stroke_fill_attribute(io : IO)
    io << %Q[shape-rendering="#{shape_rendering}" ] if shape_rendering
    io << %Q[color="#{color}" ] if color
    io << %Q[color-interpolation="#{color_interpolation}" ] if color_interpolation
    io << %Q[color-interpolation-filters="#{color_interpolation_filters}" ] if color_interpolation_filters
    io << %Q[stroke="#{stroke}" ] if stroke
    io << %Q[fill="#{fill}" ] if fill
    io << %Q[stroke-width="#{stroke_width}#{stroke_width_units}" ] if stroke_width
    io << %Q[fill-opacity="#{fill_opacity}" ] if fill_opacity
    io << %Q[stroke-opacity="#{stroke_opacity}" ] if stroke_opacity
    io << %Q[fill-rule="evenodd" ] if fill_rule

    io << %Q[stroke-dasharray="#{dash_array.join(" ")}" ] unless dash_array.empty?
    io << %Q[stroke-dashoffset="#{dash_offset}#{dash_offset_units}" ] if dash_offset
    io << %Q[stroke-linejoin="#{line_join}" ] if line_join
    io << %Q[stroke-linecap="#{line_cap}" ] if line_cap
    io << %Q[stroke-miterlimit="#{miter_limit}#{miter_limit_units}" ] if miter_limit

    io << %Q[opacity="#{opacity}" ] if opacity
  end

  module Attrs
    COLOR = "color"
    COLOR_INTERPOLATION = "color_interpolation"
    COLOR_INTERPOLATION_FILTERS = "color_interpolation_filters"
    STROKE = "stroke"
    FILL = "fill"
    STROKE_WIDTH = "stroke-width"
    FILL_OPACITY = "fill-opacity"
    STROKE_OPACITY = "stroke-opacity"
    OPACITY = "opacity"
    FILL_RULE = "fill-rule"
    DASH_ARRAY = "stroke-dasharray"
    DASH_OFFSET = "stroke-dashoffset"
    LINE_JOIN = "stroke-linejoin"
    LINE_CAP = "stroke-linecap"
    MITER_LIMIT = "stroke-miterlimit"
  end
end