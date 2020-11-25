module Celestine::Modules::Body
  include Celestine::Modules::Position

  property width : SIFNumber?
  property height : SIFNumber?
  
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
    io << %Q[width="#{width}" ]    if width
    io << %Q[height="#{height}" ]    if height 
  end

  module Attrs
    WIDTH = "width"
    HEIGHT = "height"
  end
end