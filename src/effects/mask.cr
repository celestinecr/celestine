struct Celestine::Mask < Celestine::Drawable
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  

  @objects = [] of Celestine::Drawable

  def draw
    s = String::Builder.new
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?

    
    s << %Q[<mask #{options.join(" ")}>]
    s << animate_tags
    s << animate_motion_tags



    @objects.each do |drawable|
      s << drawable.draw
    end
    s << %Q[</mask>]

    s.to_s
  end
end