# Gives a drawable access to the transform DSL
module Celestine::Modules::Transform
  @transform_meta = Celestine::Drawable::Transform.new

  def transform(&block : Celestine::Drawable::Transform ->)
    meta = Celestine::Drawable::Transform.new
    yield meta
    unless meta.empty?
      @transform_meta = meta
    end
    meta
  end

  def transform_attribute(io : IO)
    unless @transform_meta.empty?
      io << %Q[transform="]
      io << @transform_meta.objects_io
      io << %Q[" ]
    end
  end

  module Attrs
    TRANSFORM = "transform"
  end
end
