# A class which represents an SVG path.
# Supports traditional short SVG methods (a_move, r_line, etc.) as well as a fluent, chainable API (move_to, line_to, etc.),
# Point/Tuple overloads, procedural shape builders (star, polygon, arc sector, rounded rect, heart), and turtle graphics.
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path)
class Celestine::Path < Celestine::Drawable
  TAG = "path"

  include_options Celestine::Modules::StrokeFill
  include_options Celestine::Modules::Transform
  include_options Celestine::Modules::Mask
  include_options Celestine::Modules::Filter
  include_options Celestine::Modules::Clip
  include_options Celestine::Modules::Marker

  # Do not allow these to add their ATTRS since they are their own elements
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Animate::Transform

  # Storage for path code points
  @code_points = IO::Memory.new
  # Finalized code
  @code = ""

  # --------------------------------------------------------------------------
  # Short / Classic SVG Command Methods (Chainable)
  # --------------------------------------------------------------------------

  # Moves to an absolute point
  def a_move(x : Number, y : Number) : self
    @code_points << 'M' << x << ',' << y
    self
  end

  # Moves to a relative point
  def r_move(dx : Number, dy : Number) : self
    @code_points << 'm' << dx << ',' << dy
    self
  end

  # Draws a line to an absolute point
  def a_line(x : Number, y : Number) : self
    @code_points << 'L' << x << ',' << y
    self
  end

  # Draws a line to a relative point
  def r_line(dx : Number, dy : Number) : self
    @code_points << 'l' << dx << ',' << dy
    self
  end

  # Draws a horizontal line to an absolute point
  def a_h_line(x : Number) : self
    @code_points << 'H' << x
    self
  end

  # Draws a horizontal line to a relative point
  def r_h_line(dx : Number) : self
    @code_points << 'h' << dx
    self
  end

  # Draws a vertical line to an absolute point
  def a_v_line(y : Number) : self
    @code_points << 'V' << y
    self
  end

  # Draws a vertical line to a relative point
  def r_v_line(dy : Number) : self
    @code_points << 'v' << dy
    self
  end

  def a_bcurve(cx1 : Number, cy1 : Number, cx2 : Number, cy2 : Number, x : Number, y : Number) : self
    @code_points << 'C' << cx1 << ',' << cy1 << ' ' << cx2 << ',' << cy2 << ' ' << x << ',' << y
    self
  end

  def r_bcurve(dcx1 : Number, dcy1 : Number, dcx2 : Number, dcy2 : Number, dx : Number, dy : Number) : self
    @code_points << 'c' << dcx1 << ',' << dcy1 << ' ' << dcx2 << ',' << dcy2 << ' ' << dx << ',' << dy
    self
  end

  def a_s_bcurve(cx2 : Number, cy2 : Number, x : Number, y : Number) : self
    @code_points << 'S' << cx2 << ',' << cy2 << ' ' << x << ',' << y
    self
  end

  def r_s_bcurve(dcx2 : Number, dcy2 : Number, dx : Number, dy : Number) : self
    @code_points << 's' << dcx2 << ',' << dcy2 << ' ' << dx << ',' << dy
    self
  end

  def a_q_bcurve(cx : Number, cy : Number, x : Number, y : Number) : self
    @code_points << 'Q' << cx << ',' << cy << ' ' << x << ',' << y
    self
  end

  def r_q_bcurve(dcx : Number, dcy : Number, dx : Number, dy : Number) : self
    @code_points << 'q' << dcx << ',' << dcy << ' ' << dx << ',' << dy
    self
  end

  def a_t_bcurve(x : Number, y : Number) : self
    @code_points << 'T' << x << ',' << y
    self
  end

  def r_t_bcurve(dx : Number, dy : Number) : self
    @code_points << 't' << dx << ',' << dy
    self
  end

  def a_arc(x : Number, y : Number, rx : Number, ry : Number, rotation : Number = 0, large : Bool = false, flip : Bool = false) : self
    @code_points << 'A' << rx << ',' << ry << ',' << rotation << ',' << (large ? 1 : 0) << ',' << (flip ? 1 : 0) << ',' << x << ',' << y
    self
  end

  def r_arc(dx : Number, dy : Number, rx : Number, ry : Number, rotation : Number = 0, large : Bool = false, flip : Bool = false) : self
    @code_points << 'a' << rx << ',' << ry << ',' << rotation << ',' << (large ? 1 : 0) << ',' << (flip ? 1 : 0) << ',' << dx << ',' << dy
    self
  end

  # Closes the path.
  def close : self
    @code_points << 'z'
    self
  end

  # --------------------------------------------------------------------------
  # Fluent Verb Aliases & Point Overloads
  # --------------------------------------------------------------------------

  # Moves cursor to absolute coordinates (M)
  def move_to(x : Number, y : Number) : self; a_move(x, y); end
  def move_to(pt : Celestine::Point | Celestine::FPoint | Tuple(IFNumber, IFNumber)) : self
    case pt
    when Tuple(IFNumber, IFNumber) then a_move(pt[0], pt[1])
    else a_move(pt.x, pt.y)
    end
  end

  # Moves cursor by relative offset (m)
  def move_by(dx : Number, dy : Number) : self; r_move(dx, dy); end
  def move_by(pt : Celestine::Point | Celestine::FPoint | Tuple(IFNumber, IFNumber)) : self
    case pt
    when Tuple(IFNumber, IFNumber) then r_move(pt[0], pt[1])
    else r_move(pt.x, pt.y)
    end
  end

  # Draws line to absolute coordinates (L)
  def line_to(x : Number, y : Number) : self; a_line(x, y); end
  def line_to(pt : Celestine::Point | Celestine::FPoint | Tuple(IFNumber, IFNumber)) : self
    case pt
    when Tuple(IFNumber, IFNumber) then a_line(pt[0], pt[1])
    else a_line(pt.x, pt.y)
    end
  end

  # Draws line by relative offset (l)
  def line_by(dx : Number, dy : Number) : self; r_line(dx, dy); end
  def line_by(pt : Celestine::Point | Celestine::FPoint | Tuple(IFNumber, IFNumber)) : self
    case pt
    when Tuple(IFNumber, IFNumber) then r_line(pt[0], pt[1])
    else r_line(pt.x, pt.y)
    end
  end

  # Horizontal line to absolute coordinate (H)
  def horizontal_to(x : Number) : self; a_h_line(x); end
  def horizontal_by(dx : Number) : self; r_h_line(dx); end

  # Vertical line to absolute coordinate (V)
  def vertical_to(y : Number) : self; a_v_line(y); end
  def vertical_by(dy : Number) : self; r_v_line(dy); end

  # Cubic Bézier curve to absolute destination (C)
  def curve_to(cx1 : Number, cy1 : Number, cx2 : Number, cy2 : Number, x : Number, y : Number) : self
    a_bcurve(cx1, cy1, cx2, cy2, x, y)
  end

  def curve_to(c1 : Tuple(IFNumber, IFNumber) | Celestine::FPoint | Celestine::Point,
               c2 : Tuple(IFNumber, IFNumber) | Celestine::FPoint | Celestine::Point,
               to : Tuple(IFNumber, IFNumber) | Celestine::FPoint | Celestine::Point) : self
    cx1 = c1.is_a?(Tuple) ? c1[0] : c1.x
    cy1 = c1.is_a?(Tuple) ? c1[1] : c1.y
    cx2 = c2.is_a?(Tuple) ? c2[0] : c2.x
    cy2 = c2.is_a?(Tuple) ? c2[1] : c2.y
    tx  = to.is_a?(Tuple) ? to[0] : to.x
    ty  = to.is_a?(Tuple) ? to[1] : to.y
    a_bcurve(cx1, cy1, cx2, cy2, tx, ty)
  end

  # Cubic Bézier curve by relative offset (c)
  def curve_by(dcx1 : Number, dcy1 : Number, dcx2 : Number, dcy2 : Number, dx : Number, dy : Number) : self
    r_bcurve(dcx1, dcy1, dcx2, dcy2, dx, dy)
  end

  # Smooth Cubic Bézier curve to absolute destination (S)
  def smooth_curve_to(cx2 : Number, cy2 : Number, x : Number, y : Number) : self
    a_s_bcurve(cx2, cy2, x, y)
  end

  def smooth_curve_by(dcx2 : Number, dcy2 : Number, dx : Number, dy : Number) : self
    r_s_bcurve(dcx2, dcy2, dx, dy)
  end

  # Quadratic Bézier curve to absolute destination (Q)
  def quad_to(cx : Number, cy : Number, x : Number, y : Number) : self
    a_q_bcurve(cx, cy, x, y)
  end

  def quad_by(dcx : Number, dcy : Number, dx : Number, dy : Number) : self
    r_q_bcurve(dcx, dcy, dx, dy)
  end

  # Smooth Quadratic Bézier curve to absolute destination (T)
  def smooth_quad_to(x : Number, y : Number) : self
    a_t_bcurve(x, y)
  end

  def smooth_quad_by(dx : Number, dy : Number) : self
    r_t_bcurve(dx, dy)
  end

  # Elliptical arc to absolute destination (A)
  def arc_to(rx : Number, ry : Number, rotation : Number = 0, large : Bool = false, sweep : Bool = false, x : Number = 0, y : Number = 0) : self
    a_arc(x, y, rx, ry, rotation, large, sweep)
  end

  def arc_to(rx : Number, ry : Number, to : Tuple(IFNumber, IFNumber) | Celestine::FPoint | Celestine::Point, rotation : Number = 0, large : Bool = false, sweep : Bool = false) : self
    tx = to.is_a?(Tuple) ? to[0] : to.x
    ty = to.is_a?(Tuple) ? to[1] : to.y
    a_arc(tx, ty, rx, ry, rotation, large, sweep)
  end

  # Elliptical arc by relative offset (a)
  def arc_by(rx : Number, ry : Number, rotation : Number = 0, large : Bool = false, sweep : Bool = false, dx : Number = 0, dy : Number = 0) : self
    r_arc(dx, dy, rx, ry, rotation, large, sweep)
  end

  # Closes current path
  def close_path : self; close; end

  # --------------------------------------------------------------------------
  # High-Level Procedural Shape Builders
  # --------------------------------------------------------------------------

  # Generates a regular polygon with `sides` vertices centered at (cx, cy)
  def regular_polygon(cx : Number, cy : Number, sides : Int32, radius : Number, start_angle : Float64 = -90.0) : self
    raise ArgumentError.new("Polygon must have at least 3 sides") if sides < 3
    angle_step = (360.0 / sides) * (::Math::PI / 180.0)
    base_angle = start_angle * (::Math::PI / 180.0)

    sides.times do |i|
      angle = base_angle + (i * angle_step)
      px = cx + (radius * ::Math.cos(angle))
      py = cy + (radius * ::Math.sin(angle))
      if i == 0
        move_to(px, py)
      else
        line_to(px, py)
      end
    end
    close
  end

  # Generates a symmetrical star with `points` outer peaks centered at (cx, cy)
  def star(cx : Number, cy : Number, points : Int32, outer_radius : Number, inner_radius : Number, start_angle : Float64 = -90.0) : self
    raise ArgumentError.new("Star must have at least 3 points") if points < 3
    total_vertices = points * 2
    angle_step = (360.0 / total_vertices) * (::Math::PI / 180.0)
    base_angle = start_angle * (::Math::PI / 180.0)

    total_vertices.times do |i|
      r = i.even? ? outer_radius : inner_radius
      angle = base_angle + (i * angle_step)
      px = cx + (r * ::Math.cos(angle))
      py = cy + (r * ::Math.sin(angle))
      if i == 0
        move_to(px, py)
      else
        line_to(px, py)
      end
    end
    close
  end

  # Generates an arc ring sector (annular sector) between start_angle and end_angle (in degrees)
  def arc_sector(cx : Number, cy : Number, r_inner : Number, r_outer : Number, start_angle : Number, end_angle : Number) : self
    deg2rad = ::Math::PI / 180.0
    a1 = start_angle * deg2rad
    a2 = end_angle * deg2rad
    span = (end_angle - start_angle).abs
    large_arc = span > 180.0

    p_in_start_x  = cx + (r_inner * ::Math.cos(a1))
    p_in_start_y  = cy + (r_inner * ::Math.sin(a1))
    p_in_end_x    = cx + (r_inner * ::Math.cos(a2))
    p_in_end_y    = cy + (r_inner * ::Math.sin(a2))

    p_out_start_x = cx + (r_outer * ::Math.cos(a1))
    p_out_start_y = cy + (r_outer * ::Math.sin(a1))
    p_out_end_x   = cx + (r_outer * ::Math.cos(a2))
    p_out_end_y   = cy + (r_outer * ::Math.sin(a2))

    move_to(p_out_start_x, p_out_start_y)
    arc_to(r_outer, r_outer, rotation: 0, large: large_arc, sweep: true, x: p_out_end_x, y: p_out_end_y)
    line_to(p_in_end_x, p_in_end_y)
    arc_to(r_inner, r_inner, rotation: 0, large: large_arc, sweep: false, x: p_in_start_x, y: p_in_start_y)
    close
  end

  # Generates a rounded rectangle path
  def rounded_rect(x : Number, y : Number, width : Number, height : Number, rx : Number, ry : Number = rx) : self
    rx = width / 2 if rx > width / 2
    ry = height / 2 if ry > height / 2

    move_to(x + rx, y)
    horizontal_to(x + width - rx)
    arc_to(rx, ry, rotation: 0, large: false, sweep: true, x: x + width, y: y + ry)
    vertical_to(y + height - ry)
    arc_to(rx, ry, rotation: 0, large: false, sweep: true, x: x + width - rx, y: y + height)
    horizontal_to(x + rx)
    arc_to(rx, ry, rotation: 0, large: false, sweep: true, x: x, y: y + height - ry)
    vertical_to(y + ry)
    arc_to(rx, ry, rotation: 0, large: false, sweep: true, x: x + rx, y: y)
    close
  end

  # Generates a heart shape centered at (cx, cy)
  def heart(cx : Number, cy : Number, size : Number) : self
    top_y = cy - (size * 0.4)
    bot_y = cy + (size * 0.6)
    w = size * 0.5

    move_to(cx, cy - (size * 0.15))
    curve_to(cx - (w * 0.8), top_y - (size * 0.2), cx - w, cy + (size * 0.1), cx, bot_y)
    curve_to(cx + w, cy + (size * 0.1), cx + (w * 0.8), top_y - (size * 0.2), cx, cy - (size * 0.15))
    close
  end

  # --------------------------------------------------------------------------
  # Rough / Sketchy Shapes
  # --------------------------------------------------------------------------

  # Draws a hand-drawn sketchy line
  def rough_line(x1 : Number, y1 : Number, x2 : Number, y2 : Number, roughness : Float64 = 1.0, bowing : Float64 = 1.0, seed : UInt64 = 42_u64) : self
    Celestine::Rough.new(roughness: roughness, bowing: bowing, seed: seed).line(self, x1, y1, x2, y2)
    self
  end

  # Draws a hand-drawn sketchy rectangle
  def rough_rect(x : Number, y : Number, width : Number, height : Number, roughness : Float64 = 1.0, bowing : Float64 = 1.0, seed : UInt64 = 42_u64) : self
    Celestine::Rough.new(roughness: roughness, bowing: bowing, seed: seed).rect(self, x, y, width, height)
    self
  end

  # Draws a hand-drawn sketchy circle
  def rough_circle(cx : Number, cy : Number, r : Number, roughness : Float64 = 1.0, bowing : Float64 = 1.0, seed : UInt64 = 42_u64) : self
    Celestine::Rough.new(roughness: roughness, bowing: bowing, seed: seed).circle(self, cx, cy, r)
    self
  end

  # Draws a hand-drawn sketchy polygon
  def rough_polygon(points : Array(Tuple(IFNumber, IFNumber)) | Array(Celestine::Point) | Array(Celestine::FPoint), roughness : Float64 = 1.0, bowing : Float64 = 1.0, seed : UInt64 = 42_u64) : self
    Celestine::Rough.new(roughness: roughness, bowing: bowing, seed: seed).polygon(self, points)
    self
  end

  # --------------------------------------------------------------------------
  # Turtle Graphics Engine
  # --------------------------------------------------------------------------

  # Turtle graphics cursor for relative angle/distance path construction
  class Turtle
    property x : Float64
    property y : Float64
    property angle : Float64 # in degrees
    getter path : Celestine::Path

    def initialize(@path : Celestine::Path, start_x : Number = 0.0, start_y : Number = 0.0, @angle : Float64 = 0.0)
      @x = start_x.to_f64
      @y = start_y.to_f64
      @path.move_to(@x, @y)
    end

    # Moves turtle forward by distance while drawing a line
    def forward(distance : Number) : self
      rad = @angle * (::Math::PI / 180.0)
      @x += distance * ::Math.cos(rad)
      @y += distance * ::Math.sin(rad)
      @path.line_to(@x, @y)
      self
    end

    # Moves turtle forward by distance without drawing a line
    def jump(distance : Number) : self
      rad = @angle * (::Math::PI / 180.0)
      @x += distance * ::Math.cos(rad)
      @y += distance * ::Math.sin(rad)
      @path.move_to(@x, @y)
      self
    end

    # Rotates turtle angle in degrees (clockwise positive)
    def turn(degrees : Number) : self
      @angle = (@angle + degrees) % 360.0
      self
    end

    def turn_right(degrees : Number = 90.0) : self; turn(degrees); end
    def turn_left(degrees : Number = 90.0) : self; turn(-degrees); end

    # Closes current turtle path
    def close : self
      @path.close
      self
    end
  end

  # Opens a turtle graphics drawing session
  def turtle(start_x : Number = 0.0, start_y : Number = 0.0, angle : Float64 = 0.0, &block : Turtle ->) : self
    t = Turtle.new(self, start_x, start_y, angle)
    yield t
    self
  end

  # --------------------------------------------------------------------------
  # Serialization
  # --------------------------------------------------------------------------

  # Finalized path code points.
  #
  # * [Understanding Path Code](https://css-tricks.com/svg-path-syntax-illustrated-guide/)
  def code : String
    @code = @code_points.to_s if @code.empty?
    @code
  end

  def code=(other : String)
    @code = other
  end

  def draw(io : IO) : Nil
    io << '<' << TAG << ' '
    draw_attributes(io)

    d_code = code
    unless d_code.empty?
      io << "d=\"" << d_code << "\" "
    end

    if !has_inner_elements?
      io << "/>"
    else
      io << '>'
      io << inner_elements
      io << "</" << TAG << '>'
    end
  end
end
