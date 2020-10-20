struct Celestine::Text < Celestine::Drawable 
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Position
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Mask

  property text : String = ""

  property dx : SIFNumber?
  property dy : SIFNumber?

  property rotate : SIFNumber?
  property length : SIFNumber?
  property length_adjust : SIFNumber?

  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?
    options << custom_options unless custom_options.empty?

    options << %Q[dx="#{dx}"]                               if dx
    options << %Q[dy="#{dy}"]                               if dy
    options << %Q[rotate="#{rotate}"]                       if rotate
    options << %Q[textLength="#{length}"]                   if length
    options << %Q[lengthAdjust="#{length_adjust}"]          if length_adjust

    inner_tags = String::Builder.new
    inner_tags << animate_tags
    inner_tags << animate_motion_tags
    inner_tags << text
    tags = inner_tags.to_s
    if tags.empty?
      %Q[<text #{options.join(" ")} />]
    else
      %Q[<text #{options.join(" ")}>#{tags}</text>]
    end
  end

  module Attrs
    DX = "dx"
    DY = "dy"
    ROTATE = "rotate"
    LENGTH = "textLength"
    LENGTH_ADJUST = "lengthAdjust"
  end
end