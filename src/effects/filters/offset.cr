class Celestine::Filter::Offset < Celestine::Drawable
  TAG = "feOffset"
  include_options Celestine::Modules::Animate

  property input : String? = nil
  property result : String? = nil
  make_units dx
  make_units dy

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    io << %Q[in="#{input}" ] if input
    io << %Q[result="#{result}" ] if result
    io << %Q[dx="#{dx}#{dx_units}" ] if dx
    io << %Q[dy="#{dy}#{dy_units}" ] if dy


    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    DX = "dx"
    DY = "dy"
  end
end