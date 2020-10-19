struct Celestine::Text < Celestine::Drawable 
  include Celestine::Modules::Transform
  include Celestine::Modules::Position
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Mask

  property text : String = ""

  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?

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
end