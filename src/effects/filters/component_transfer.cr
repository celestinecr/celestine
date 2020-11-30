# Transfers color components
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feComponentTransfer)
class Celestine::Filter::ComponentTransfer < Celestine::Filter::Basic
  TAG = "feComponentTransfer"

  # The input source
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/in)
  property input : String? = nil

  make_component_transfer_funcs("r")
  make_component_transfer_funcs("b")
  make_component_transfer_funcs("g")
  make_component_transfer_funcs("a")

  # Draws this component transfer filter to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)

    io << %Q[in="#{input}" ] if input
    io << %Q[result="#{result}" ] if result

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
    INPUT = "in"
  end
end

# Basic class for `Celestine::Filter::ComponentTransfer` inner elements. Shouldn't be needed to be used for anything else.
abstract class Celestine::Filter::ComponentTransfer::Func < Celestine::Drawable
  TAG = "WARNING FUNC NOT MEANT TO BE USED!"

  property type : String? = nil
  property table_values : Array(IFNumber) = [] of IFNumber
  property slope : IFNumber?
  property intercept : IFNumber?
  property amplitude : IFNumber?
  property exponent : IFNumber?
  property offset : IFNumber?

  macro add_draw
    def draw(io : IO) : Nil
      io << "<#{TAG} "
      draw_attributes(io)

      io << "type=\"#{type}\" " if type
      io << "slope=\"#{slope}\" " if slope
      io << "intercept=\"#{intercept}\" " if intercept
      io << "amplitude=\"#{amplitude}\" " if amplitude
      io << "exponent=\"#{exponent}\" " if exponent
      io << "offset=\"#{offset}\" " if offset

      unless table_values.empty?
        io << "tableValues=\""
        table_values.join(io, " ")
        io << "\" "
      end
      if inner_elements.empty?
        io << "/>"
      else
        io << ">"
        io << inner_elements
        io << "</#{TAG}>"
      end
    end
  end

  module Attrs
    INPUT = "in"
  end
end

class Celestine::Filter::ComponentTransfer::FuncR < Celestine::Filter::ComponentTransfer::Func
  TAG = "feFuncR"
  Celestine::Filter::ComponentTransfer::Func.add_draw
end

class Celestine::Filter::ComponentTransfer::FuncG < Celestine::Filter::ComponentTransfer::Func
  TAG = "feFuncG"
  Celestine::Filter::ComponentTransfer::Func.add_draw
end

class Celestine::Filter::ComponentTransfer::FuncB < Celestine::Filter::ComponentTransfer::Func
  TAG = "feFuncB"
  Celestine::Filter::ComponentTransfer::Func.add_draw
end

class Celestine::Filter::ComponentTransfer::FuncA < Celestine::Filter::ComponentTransfer::Func
  TAG = "feFuncA"
  Celestine::Filter::ComponentTransfer::Func.add_draw
end