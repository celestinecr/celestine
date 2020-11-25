module Celestine::Modules::StrokeFill
  property stroke : String?  = nil
  property fill : String? = nil
  property stroke_width : SIFNumber? = nil
  property fill_opacity : SIFNumber? = nil
  property stroke_opacity : SIFNumber? = nil
  property dash_array : Array(SIFNumber) = [] of SIFNumber
  property dash_offset : SIFNumber? = nil
  property line_join : String? = nil
  property miter_limit : SIFNumber? = nil
  property line_cap : String? = nil


  property opacity : SIFNumber?
  property fill_rule : Bool = false
  
  def stroke_fill_attribute(io : IO)
    io << %Q[stroke="#{stroke}" ] if stroke
    io << %Q[fill="#{fill}" ] if fill
    io << %Q[stroke-width="#{stroke_width}" ] if stroke_width
    io << %Q[fill-opacity="#{fill_opacity}" ] if fill_opacity
    io << %Q[stroke-opacity="#{stroke_opacity}" ] if stroke_opacity
    io << %Q[fill-rule="evenodd" ] if fill_rule

    io << %Q[stroke-dasharray="#{dash_array.join(" ")}" ] unless dash_array.empty?
    io << %Q[stroke-dashoffset="#{dash_offset}" ] if dash_offset
    io << %Q[stroke-linejoin="#{line_join}" ] if line_join
    io << %Q[stroke-linecap="#{line_cap}" ] if line_cap
    io << %Q[stroke-miterlimit="#{miter_limit}" ] if miter_limit

    io << %Q[opacity="#{opacity}" ] if opacity
  end

  module Attrs
    STROKE = "stroke"
    FILL = "fill"
    STROKE_WIDTH = "stroke-width"
    FILL_OPACITY = "fill-opacity"
    STROKE_OPACITY = "stroke-opacity"
    OPACITY = "opacity"
    FILL_RULE = "fill-rule"
  end
end