class Celestine::Circle < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Transform
  include Celestine::Modules::Animate

  
  property radius : SIFNumber = 0


  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    if anim_tags = animate_tags
      %Q[<circle r="#{radius}" #{options.join(" ")}>#{anim_tags}</circle>]

    else
      %Q[<circle r="#{radius}" #{options.join(" ")} />]
    end
  end

  module Attrs
    X = "cx"
    Y = "cy"
    RADIUS = "r"
    STROKE = "stroke"
    FILL = "fill"
    STROKE_WIDTH = "stroke-width"
    FILL_OPACITY = "fill-opacity"
    STROKE_OPACITY = "stroke-opacity"
    OPACITY = "opacity"
    FILL_RULE = "fill-rule"
  end
end