# Gives drawables access to basic X, Y, W, H paramaters
module Celestine::Modules::Body
  include Celestine::Modules::Position

  make_units :width
  make_units :height

  # Draws the body and position attributes to an `IO`
  def body_attribute(io)
    io << %Q[width="#{width}#{width_units}" ]    if width
    io << %Q[height="#{height}#{height_units}" ]    if height 
  end

  module Attrs
    WIDTH = "width"
    HEIGHT = "height"
  end
end