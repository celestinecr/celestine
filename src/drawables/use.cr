# Allows reuse of another drawable by ID
# 
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/use)
class Celestine::Use < Celestine::Drawable
  TAG = "use"

  include_options Celestine::Modules::Body
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  
  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # The ID to be reused
  # 
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/href)
  property target_id : String = ""

  def initialize()
  end

  def initialize(@target_id : Sting)
  end

  def initialize(target : Celestine::Drawable)
    if target.id
      @target_id = target.id.as(String)
    else
      raise "No id on target #{target}"
    end
  end
  
  # Draws this use to the IO
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    draw_attributes(io)


    io << %Q[href="##{target_id}" ]

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end