module Celestine::Modules::Body
  include Celestine::Modules::Position

  make_units :width
  make_units :height

  def body_attribute(io)
    position_attribute(io)
    io << %Q[width="#{width}#{width_units}" ]    if width
    io << %Q[height="#{height}#{height_units}" ]    if height 
  end

  module Attrs
    WIDTH = "width"
    HEIGHT = "height"
  end
end