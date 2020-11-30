# Gives a drawable access to stroke, fill, and opacity attributes, as well as other related attributes
module Celestine::Modules::StrokeFill
  # The color of the stroke
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke)
  property stroke : String?

  # The color of the fill
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill)
  property fill : String?

  # The width of the stroke
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-width)
  make_units stroke_width

  # The opacity of the fill
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill-opacity)
  property fill_opacity : IFNumber?

  # The opacity of the fill
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-opacity)
  property stroke_opacity : IFNumber?

  # An array representing the amount of units a line should be "on" and "off" for.
  # 
  # An array of `[3]` will dash the line for 3 units, then off for 3 units, then repeats until the line is finished.
  # An array of `[3 3]` will dash the line for 3 units, then off for 3 units, then repeats until the line is finished. The same as `[3]`
  # An array of `[4 2]` will dash the line for 4 units, then off for 2 units, then repeats until the line is finished.
  # You can add more of these to make much more complicated dashed lines.
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-dasharray)
  property dash_array : Array(Float64) = [] of Float64

  # The offset to begin dashes on
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-dashoffset)
  make_units dash_offset

  
  # The offset to begin dashes on
  # 
  # Potential Values: `arcs | bevel |miter | miter-clip | round`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linejoin)
  property line_join : String?


  # The limit on the ratio of the miter length to the stroke-width used to draw a miter join. When the limit is exceeded, the join is converted from a miter to a bevel.
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-miterlimit)
  make_units miter_limit


  # How a line is capped at the ends
  # 
  # Potential Values: `butt | round | square`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linecap)
  property line_cap : String?

  # The total opacity of the drawable
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/opacity)
  property opacity : IFNumber?

  # The algorithm to use to determine the inside part of a shape.
  # 
  # Potential Values: `nonzero | evenodd`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/fill-rule)
  property fill_rule : Bool = false

  # The inherited/inheriting color of the drawable
  # 
  # * Potential Values: `<Any CSS Color Type> | currentColor`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/color)
  property color : String?

  # Specifies the color space for gradient interpolations, color animations, and alpha compositing
  # 
  # * Potential Values: `auto | sRGB | linearRGB`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/color-interpolation)
  property color_interpolation : String?

  # Specifies the color space for imaging operations performed via filter effects.
  # 
  # * Potential Values: `auto | sRGB | linearRGB`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/color-interpolation-filters)
  property color_interpolation_filters : String?
  
  # Provides hints to the renderer about what tradeoffs to make when rendering shapes like paths, circles, or rectangles.
  # 
  # * Potential Values: `auto | optimizeSpeed | crispEdges | geometricPrecision`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/shape-rendering)
  property shape_rendering : String?

  # Provides hints to the renderer about what tradeoffs to make when rendering shapes like paths, circles, or rectangles.
  # 
  # * Potential Values: `none | non-scaling-stroke | non-scaling-size | non-rotation | fixed-position`
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/vector-effect)
  property vector_effect : String?

  # Draws the stroke and fill attributes out to an `IO`
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
    io << %Q[vector-effect="#{vector_effect}" ] if vector_effect
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
    VECTOR_EFFECT = "vector-effect"
  end
end