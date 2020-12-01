class Celestine::Mask < Celestine::Drawable
  TAG = "mask"
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Body

  @objects_io = IO::Memory.new

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    inner_elements << @objects_io
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end