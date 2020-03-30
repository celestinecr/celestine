class Celestine::Rectangle < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::Body
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Transform
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  
  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << body_options unless body_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?

    inner_tags = String::Builder.new
    inner_tags << animate_tags
    inner_tags << animate_motion_tags
    tags = inner_tags.to_s
    if tags.empty?
      %Q[<rect #{options.join(" ")} />]
    else
      %Q[<rect #{options.join(" ")}>#{tags}</rect>]
    end
  end





end