class Celestine::Pattern < Celestine::Drawable
  TAG = "pattern"
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include Celestine::Modules::Animate
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Body

  property href : String?
  property pattern_units : String?
  property pattern_content_units : String?
  property preserve_aspect_ratio : String?
  property view_box : Celestine::ViewBox?

  @pattern_transform_meta = Celestine::Drawable::Transform.new

  def pattern_transform(&block : Celestine::Drawable::Transform -> Celestine::Drawable::Transform)
    meta = yield Celestine::Drawable::Transform.new
    unless meta.empty?
      @pattern_transform_meta = meta
    end
  end

  def pattern_transform_attribute(io : IO)
    unless @pattern_transform_meta.empty?
      io << %Q[#{Attrs::PATTERN_TRANSFORM}="]
      io << @pattern_transform_meta.objects_io
      io << %Q[" ]
    end
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::PRESERVE_ASPECT_RATIO}="#{preserve_aspect_ratio}" ] if preserve_aspect_ratio
    if vb = view_box
      io << %Q[#{Attrs::VIEW_BOX}="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}" ]
    end
    io << %Q[#{Attrs::PATTERN_UNITS}="#{pattern_units}" ] if pattern_units
    io << %Q[#{Attrs::PATTERN_CONTENT_UNITS}="#{pattern_content_units}" ] if pattern_content_units
    io << %Q[#{Attrs::HREF}="#{href}" ] if href

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    HREF                  = "href"
    PRESERVE_ASPECT_RATIO = "preserveAspectRatio"
    PATTERN_UNITS         = "patternUnits"
    PATTERN_CONTENT_UNITS = "patternContentUnits"
    VIEW_BOX              = "viewBox"
    PATTERN_TRANSFORM     = "patternTransform"
  end
end
