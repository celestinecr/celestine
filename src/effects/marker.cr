# https://developer.mozilla.org/en-US/docs/Web/SVG/Element/marker
class Celestine::Marker < Celestine::Drawable
  TAG = "marker"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Filter

  make_units height
  make_units width
  property units : String?
  property orientation : String?
  property preserve_aspect_ratio : String?
  property ref_x : String?
  property ref_y : String?
  property view_box : Celestine::Meta::Context::ViewBox?

  @objects_io = IO::Memory.new

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[#{Attrs::HEIGHT}="#{height}#{height_units}" ] if height
    io << %Q[#{Attrs::WIDTH}="#{width}#{width_units}" ] if width
    io << %Q[#{Attrs::UNITS}="#{units}" ] if units
    io << %Q[#{Attrs::PRESERVE_ASPECT_RATIO}="#{preserve_aspect_ratio}" ] if preserve_aspect_ratio
    io << %Q[#{Attrs::REF_X}="#{ref_x}" ] if ref_x
    io << %Q[#{Attrs::REF_Y}="#{ref_y}" ] if ref_y
    if @view_box
      vb = @view_box.as(Celestine::Meta::Context::ViewBox)
      io << %Q[#{Attrs::VIEW_BOX}="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}"]
    end
    inner_elements << @objects_io
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    HEIGHT = "markerHeight"
    WIDTH = "markerWidth"
    UNITS = "markerUnits"
    ORIENTATION = "orient"
    PRESERVE_ASPECT_RATIO = "preserveAspectRatio"
    REF_X = "refX"
    REF_Y = "refY"
    VIEW_BOX = "viewBox"
  end
end