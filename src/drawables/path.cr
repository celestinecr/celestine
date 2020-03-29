class Celestine::Path < Celestine::Drawable
  property stroke = "none"
  property fill = "none"

  @code_points = String::Builder.new

  def a_move(x, y)
    @code_points << "M#{x},#{y}"
  end

  def r_move(x, y)
    @code_points << "m#{x},#{y}"
  end

  def a_line(x, y)
    @code_points << "L#{x},#{y}"
  end

  def r_line(x, y)
    @code_points << "l#{x},#{y}"
  end

  def a_h_line(x)
    @code_points << "H#{x}"
  end

  def r_h_line(x)
    @code_points << "H#{x}"
  end

  def a_v_line(y)
    @code_points << "H#{y}"
  end

  def r_v_line(y)
    @code_points << "H#{y}"
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
    @code_points << "q#{cx2},#{cy2} #{x},#{y}"
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

  def r_arc(x, y, rx, ry, rotation = 0, large = false, sweep = false)
    @code_points << "a#{rx},#{ry},#{rotation},#{large ? 1 : 0},#{flip ? 1 : 0},#{x},#{y}"
  end

  def close
    @code_points << "z"
  end

  def draw
    %Q[<path d="#{@code_points.to_s}" stroke="#{stroke}" fill="#{fill}" #{transform_options} />]
  end
end