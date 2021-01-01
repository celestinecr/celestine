class Celestine::Animate::Motion < Celestine::Drawable
  TAG = "animateMotion"
  include_options Celestine::Modules::Animate
  include_options Celestine::Modules::CommonAnimate

  property rotate = "none"
  # This attribute indicate, in the range [0,1], how far is the object along the path for each `key_times` associated values.
  property key_points = [] of Float64
  getter mpath = ""

  def mpath(&block : Proc(Celestine::Path, Nil))
    path = yield Celestine::Path.new
    @mpath = path.code
  end

  def mpath=(path : Celestine::Path)
    @mpath = path.code
  end

  def link_mpath(path : Celestine::Path)
    if path.id
      @mpath = "##{path.id}"
    else
      raise "You must give an ID with elements you want to reuse"
    end
  end

  def link_mpath(id : String)
    @mpath = id
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    # Punctuate attributes with a space
    draw_attributes(io)

    # TODO: Find out if AnimateMotion can actually use this in any meaningful way....
    # io << %Q[from="#{from}#{from_units}" ] if from
    # io << %Q[to="#{to}#{to_units}" ] if to
    # io << %Q[by="#{by}#{by_units}" ] if by

    if mpath =~ /^#/
      inner_elements << %Q[<mpath xlink:href="#{mpath}"/>]
    else
      io << %Q[path="#{mpath}" ]
    end

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
