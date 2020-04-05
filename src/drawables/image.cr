struct Celestine::Image < Celestine::Drawable
  include Celestine::Modules::Transform
  include Celestine::Modules::Body
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Mask

  property url : String = ""
  
  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << body_options unless body_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?

    inner_tags = String::Builder.new
    inner_tags << animate_tags
    inner_tags << animate_motion_tags
    tags = inner_tags.to_s
    if tags.empty?
      %Q[<image href="#{url}" #{options.join(" ")} />]
    else
      %Q[<image href="#{url}" #{options.join(" ")}>#{tags}</image>]
    end
  end
end  