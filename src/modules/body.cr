module Celestine::Modules::Body
  property width : SIFNumber = 0
  property height : SIFNumber = 0

  def body_options
    if width != 0 && height != 0
      %Q[width="#{width}" height="#{height}"]
    elsif width != 0
      %Q[width="#{width}"]
    elsif height != 0
      %Q[height="#{height}"]
    else
      ""
    end
  end

  macro included
    Celestine::Modules::Body.make_attrs
  end

  macro make_attrs
    module Attrs
      WIDTH = "width"
      HEIGHT = "height"
    end
  end
end