# Draws and holds information for groups
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/a)
class Celestine::Anchor < Celestine::Drawable
  TAG = "a"

  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  
  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # The URI for the image
  #
  # * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/href)
  property href : String? = nil

  # Holds objects to be written to the group
  @objects_io = IO::Memory.new

  # Draws the group to an `IO`
  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]    
    draw_attributes(io)

    io << %Q[href="#{href}" ] if href


    if !@objects_io.empty? || !inner_elements.empty?
      io << %Q[>]
      io << @objects_io
      io << inner_elements
      io << %Q[</#{TAG}>]
    else
      io << %Q[/>]
    end

  end
end