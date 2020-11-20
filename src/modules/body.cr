module Celestine::Modules::Body
  include Celestine::Modules::Position

  property width : SIFNumber = 0
  property height : SIFNumber = 0
  
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
    if width != 0 && height != 0
      io << %Q[width="#{width}" height="#{height}" ]
    elsif width != 0
      io << %Q[width="#{width}" ]
    elsif height != 0
      io << %Q[height="#{height}" ]
    end
  end

  module Attrs
    WIDTH = "width"
    HEIGHT = "height"
  end
end