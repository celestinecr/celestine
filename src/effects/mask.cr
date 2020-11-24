class Celestine::Mask < Celestine::Drawable
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion

  @objects_io = IO::Memory.new

  def draw(io : IO) : Nil
    io << %Q[<mask ]
    class_attribute(io)
    id_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    inner_elements << @objects_io
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</mask>"
    end
  end
end