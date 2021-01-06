abstract class Celestine::Gradient < Celestine::Drawable
  TAG = "WARNING DO NOT USE THIS DIRECTLY!"
  include_options Celestine::Modules::Transform
  include Celestine::Modules::Animate
  include_options Celestine::Modules::Filter

  property href : String?
  property gradient_units : String?
  property spread_method : String?

  @gradient_transform_meta = Celestine::Drawable::Transform.new

  def stop(offset, color = nil, opacity = nil)
    c_stop = Celestine::Gradient::Stop.new
    c_stop.offset = offset
    c_stop.color = color
    c_stop.opacity = opacity
    c_stop
  end
  
  def stop(&block : Celestine::Gradient::Stop -> Celestine::Gradient::Stop)
    c_stop = Celestine::Gradient::Stop.new
    c_stop = yield c_stop
    c_stop.draw(inner_elements)
    c_stop
  end

  def <<(c_stop : Celestine::Gradient::Stop)
    c_stop.draw(inner_elements)
  end

  def gradient_transform(&block : Celestine::Drawable::Transform -> Celestine::Drawable::Transform)
    meta = yield Celestine::Drawable::Transform.new
    unless meta.empty?
      @gradient_transform_meta = meta
    end
  end

  def gradient_transform_attribute(io : IO)
    unless @gradient_transform_meta.empty?
      io << %Q[gradientTransform="]
      io << @gradient_transform_meta.objects_io
      io << %Q[" ]
    end
  end

  module Attrs
    HREF           = "href"
    SPREAD_METHOD  = "spreadMethod"
    GRADIENT_UNITS = "gradientUnits"
  end
end

class Celestine::Gradient::Stop < Celestine::Drawable
  TAG = "stop"
  make_units offset
  property color : String?
  property opacity : IFNumber?

  include Celestine::Modules::Animate

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[offset="#{offset}#{offset_units}" ] if offset
    io << %Q[stop-color="#{color}" ] if color
    io << %Q[stop-opacity="#{opacity}" ] if opacity

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    OFFSET  = "offset"
    COLOR   = "stop-color"
    OPACITY = "stop-opacity"
  end
end
