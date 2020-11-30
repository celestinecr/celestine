# Merges one or more filters into a single result
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feMerge)
# * [feMergeNode](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feMergeNode)
class Celestine::Filter::Merge < Celestine::Filter::Basic
  TAG = "feMerge"
  NODE_TAG = "feMergeNode"

  # Adds a new `feMergeNode` to this filter.
  def add_node(filter_name)
    inner_elements << %Q[<#{NODE_TAG} in="#{filter_name}" />]
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


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
  end
end