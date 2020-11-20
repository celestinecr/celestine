struct Celestine::Group < Celestine::Drawable
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::Animate::Motion
  include_options Celestine::Modules::Mask
  

  @objects_io = IO::Memory.new

  property? override_stroke_fill = false

  def draw(io : IO) : Nil
    io << %Q[<g ]
    class_attribute(io)
    id_attribute(io)
    stroke_fill_attribute(io)
    transform_attribute(io)
    style_attribute(io)
    mask_attribute(io)     
    custom_attribute(io)

    if !@objects_io.empty? || !inner_elements.empty?
      io << %Q[>]
      io << @objects_io
      io << inner_elements
      io << %Q[</g>]
    else
      io << %Q[/>]
    end

  end
end