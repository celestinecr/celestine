class Celestine::Image < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::Transform
  include Celestine::Modules::Body
  
  property url : String = ""
  
  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << body_options unless body_options.empty?
    options << transform_options unless transform_options.empty?
    %Q[<image href="#{url}" #{options.join(" ")} />]
  end
end  