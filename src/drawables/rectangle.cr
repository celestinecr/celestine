class Celestine::Rectangle < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Transform
  include Celestine::Modules::Body

  
  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << body_options unless body_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    %Q[<rect #{options.join(" ")} />]
  end
end