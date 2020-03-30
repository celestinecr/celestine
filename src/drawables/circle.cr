class Celestine::Circle < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Transform
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  
  property radius : SIFNumber = 0


  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?

    inner_tags = String::Builder.new
    anim_tags = animate_tags
    anim_motion_tags = animate_motion_tags

    inner_tags << anim_tags if anim_tags
    inner_tags << anim_motion_tags if anim_motion_tags

    if inner_tags
      %Q[<circle r="#{radius}" #{options.join(" ")}>#{inner_tags.to_s}</circle>]
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