module Celestine::Modules::Body
  include Celestine::Modules::Position

  make_units :width
  make_units :height

  
  # TODO: FIX SHIT LIKE PX, REM, ETC
  def left
    x.to_i
  end

  # TODO: FIX SHIT LIKE PX, REM, ETC
  def right
    left + width.to_i
  end

  # TODO: FIX SHIT LIKE PX, REM, ETC
  def top
    y.to_i
  end

  # TODO: FIX SHIT LIKE PX, REM, ETC
  def bottom
    top + height.to_i
  end

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