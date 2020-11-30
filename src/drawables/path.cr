# A class which represents an SVG path. Methods starting with a_ use absolute coordinates, while r_ methods require relative coordinates. 
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path)
class Celestine::Path < Celestine::Drawable
  TAG = "path"

  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Marker
  
  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform
  
  # Storage for path code points
  @code_points = IO::Memory.new
  # Finalized code
  @code = ""

  # Moves to an absolute point
  def a_move(x, y)
    @code_points << "M#{x},#{y}"
  end

  # Moves to a relative point
  def r_move(x, y)
    @code_points << "m#{x},#{y}"
  end

  # Draws a line to an absolute point
  def a_line(x, y)
    @code_points << "L#{x},#{y}"
  end

  # Draws a line to a relative point
  def r_line(x, y)
    @code_points << "l#{x},#{y}"
  end

  # Draws a horizontal line to an absolute point
  def a_h_line(x)
    @code_points << "H#{x}"
  end

  # Draws a horizontal line to a relative point
  def r_h_line(x)
    @code_points << "h#{x}"
  end

  # Draws a vertical line to an absolute point
  def a_v_line(y)
    @code_points << "V#{y}"
  end

  # Draws a vertical line to a relative point
  def r_v_line(y)
    @code_points << "v#{y}"
  end

  def a_bcurve(cx1, cy1, cx2, cy2, x, y)
    @code_points << "C#{cx1},#{cy1} #{cx2},#{cy2} #{x},#{y}"
  end

  def r_bcurve(cx1, cy1, cx2, cy2, x, y)
    @code_points << "c#{cx1},#{cy1} #{cx2},#{cy2} #{x},#{y}"
  end

  def a_s_bcurve(cx2, cy2, x, y)
    @code_points << "S#{cx2},#{cy2} #{x},#{y}"
  end

  def r_s_bcurve(cx2, cy2, x, y)
    @code_points << "s#{cx2},#{cy2} #{x},#{y}"
  end

  def a_q_bcurve(cx, cy, x, y)
    @code_points << "Q#{cx},#{cy} #{x},#{y}"
  end

  def r_q_bcurve(cx, cy, x, y)
    @code_points << "q#{cx},#{cy} #{x},#{y}"
  end

  def a_t_bcurve(x, y)
    @code_points << "T#{x},#{y}"
  end

  def r_t_bcurve(x, y)
    @code_points << "t#{x},#{y}"
  end

  def a_arc(x, y, rx, ry, rotation = 0, large = false, flip = false)
    @code_points << "A#{rx},#{ry},#{rotation},#{large ? 1 : 0},#{flip ? 1 : 0},#{x},#{y}"
  end

  def r_arc(x, y, rx, ry, rotation = 0, large = false, flip = false)
    @code_points << "a#{rx},#{ry},#{rotation},#{large ? 1 : 0},#{flip ? 1 : 0},#{x},#{y}"
  end

  # Closes the path.
  def close
    @code_points << "z"
  end

  # Finalized path code points. 
  #
  # * [Understanding Path Code](https://css-tricks.com/svg-path-syntax-illustrated-guide/)
  def code
    @code = @code_points.to_s if @code.empty?
    @code
  end
  
  def code=(other : String)
    @code = other
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]

    draw_attributes(io)

    io << %Q[d="#{code}" ] unless code.empty?
    
    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end
end
