module Celestine::Modules::StrokeFill
  property stroke : String?  = nil
  property fill : String? = nil
  property stroke_width : SIFNumber? = 1
  property fill_opacity : Float64? = 1.0
  property stroke_opacity : Float64? = 1.0
  property dash_array : Array(SIFNumber) = [] of SIFNumber
  property dash_offset : Int32 = 0
  property line_join : String? = nil
  property miter_limit : Int32? = 4 # Default
  property line_cap : String? = nil


  property opacity : Float64? = 1.0
  property fill_rule : Bool = false
  
  def stroke_fill_attribute(io : IO)
    # Only draw this if group agrees to override
    if self.is_a?(Celestine::Group) && self.override_stroke_fill?
      io << %Q[stroke="#{stroke}" ] if stroke
      io << %Q[fill="#{fill}" ] if fill
      io << %Q[stroke-width="#{stroke_width}" ] unless !stroke_width || stroke_width == 1 || stroke_width == 1.0 
      io << %Q[fill-opacity="#{fill_opacity}" ] unless !fill_opacity || fill_opacity == 1 || fill_opacity == 1.0
      io << %Q[stroke-opacity="#{stroke_opacity}" ] unless !stroke_opacity || stroke_opacity == 1 || stroke_opacity == 1.0
      io << %Q[fill-rule="evenodd" ] if fill_rule

      io << %Q[stroke-dasharray="#{dash_array.join(" ")}" ] unless dash_array.empty?
      io << %Q[stroke-dashoffset="#{dash_offset}" ] unless dash_offset.zero?
      io << %Q[stroke-linejoin="#{dash_offset}" ] if line_join
      io << %Q[stroke-linecap="#{line_cap}" ] if line_cap
      io << %Q[stroke-miterlimit="#{miter_limit}" ] if miter_limit && miter_limit != 4




    else
      io << %Q[stroke="#{stroke}" ] if stroke
      io << %Q[fill="#{fill}" ] if fill
      io << %Q[stroke-width="#{stroke_width}" ] unless !stroke_width || stroke_width == 1 || stroke_width == 1.0 
      io << %Q[fill-opacity="#{fill_opacity}" ] unless !fill_opacity || fill_opacity == 1 || fill_opacity == 1.0
      io << %Q[stroke-opacity="#{stroke_opacity}" ] unless !stroke_opacity || stroke_opacity == 1 || stroke_opacity == 1.0
      io << %Q[fill-rule="evenodd" ] if fill_rule

      io << %Q[stroke-dasharray="#{dash_array.join(" ")}" ] unless dash_array.empty?
      io << %Q[stroke-dashoffset="#{dash_offset}" ] unless dash_offset.zero?
      io << %Q[stroke-linejoin="#{dash_offset}" ] if line_join
      io << %Q[stroke-linecap="#{line_cap}" ] if line_cap
      io << %Q[stroke-miterlimit="#{miter_limit}" ] if miter_limit && miter_limit != 4
    end

    io << %Q[opacity="#{opacity}" ] unless !opacity || opacity == 1 || opacity == 1.0
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