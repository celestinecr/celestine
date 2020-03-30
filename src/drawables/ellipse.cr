class Celestine::Ellipse < Celestine::Drawable
  property radius_x : SIFNumber = 0
  property radius_y : SIFNumber = 0
  
  include Celestine::Modules::Transform
  include Celestine::Modules::Position
  include Celestine::Modules::StrokeFill

  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    %Q[<ellipse rx="#{radius_x}" ry="#{radius_y}" #{options.join(" ")} />]
  end
end