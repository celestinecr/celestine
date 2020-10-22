struct Celestine::Rectangle < Celestine::Drawable
  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Mask
  property radius_x : SIFNumber? = nil

  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << body_options unless body_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?
    options << custom_options unless custom_options.empty?
    options << %Q[rx="#{radius_x}"] if radius_x
    
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




  module Attrs
    RADIUS_X = "rx"
  end
end