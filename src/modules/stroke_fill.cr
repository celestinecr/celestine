module Celestine::Modules::StrokeFill
  property stroke : String?  = nil
  property fill : String? = nil
  property stroke_width : SIFNumber? = 1
  property fill_opacity : Float64? = 1.0
  property stroke_opacity : Float64? = 1.0

  property opacity : Float64? = 1.0
  property fill_rule : Bool = false
  
  def stroke_fill_options
    options = [] of String
    
    # Only draw this if group agrees to override
    if self.is_a?(Celestine::Group) && self.override_stroke_fill?
      options << %Q[stroke="#{stroke}"] if stroke
      options << %Q[fill="#{fill}"] if fill
      options << %Q[stroke-width="#{stroke_width}"] unless !stroke_width || stroke_width == 1 || stroke_width == 1.0 
      options << %Q[fill-opacity="#{fill_opacity}"] unless !fill_opacity || fill_opacity == 1 || fill_opacity == 1.0
      options << %Q[stroke-opacity="#{stroke_opacity}"] unless !stroke_opacity || stroke_opacity == 1 || stroke_opacity == 1.0
      options << %Q[fill-rule="evenodd"] if fill_rule
    else
      options << %Q[stroke="#{stroke}"] if stroke
      options << %Q[fill="#{fill}"] if fill
      options << %Q[stroke-width="#{stroke_width}"] unless !stroke_width || stroke_width == 1 || stroke_width == 1.0 
      options << %Q[fill-opacity="#{fill_opacity}"] unless !fill_opacity || fill_opacity == 1 || fill_opacity == 1.0
      options << %Q[stroke-opacity="#{stroke_opacity}"] unless !stroke_opacity || stroke_opacity == 1 || stroke_opacity == 1.0
      options << %Q[fill-rule="evenodd"] if fill_rule
    end

    options << %Q[opacity="#{opacity}"] unless !opacity || opacity == 1 || opacity == 1.0
    options.join(" ")
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