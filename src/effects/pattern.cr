class Celestine::Pattern < Celestine::Drawable
  TAG = "pattern"
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
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
      io << %Q[patternTransform="]
      io << @pattern_transform_meta.objects_io
      io << %Q[" ]
    end
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[preserveAspectRatio="#{preserve_aspect_ratio}" ] if preserve_aspect_ratio

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end