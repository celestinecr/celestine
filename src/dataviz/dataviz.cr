# Micro data-visualization primitives for Celestine
# Generates responsive sparklines, circular progress rings, and donut slices.
module Celestine::DataViz
  # Draws a sparkline trend graph for numeric time-series data
  def sparkline(
    data : Array(Number),
    x : Number,
    y : Number,
    width : Number,
    height : Number,
    stroke : String = "#0284c7",
    stroke_width : Number = 2,
    fill : String? = nil,
    smooth : Bool = false,
    &block : Celestine::Path ->
  ) : Celestine::Path
    path = Celestine::Path.new
    path.stroke = stroke
    path.stroke_width = stroke_width
    path.fill = fill || "none"

    if data.size < 2
      if data.size == 1
        path.move_to(x, y + height / 2.0)
        path.line_to(x + width, y + height / 2.0)
      end
      yield path
      self << path
      return path
    end

    min_val = data.map(&.to_f64).min
    max_val = data.map(&.to_f64).max
    val_range = max_val - min_val
    val_range = 1.0 if val_range == 0.0

    n = data.size
    dx = width.to_f64 / (n - 1)

    pts = data.map_with_index do |val, i|
      px = x.to_f64 + (i * dx)
      normalized_y = (val.to_f64 - min_val) / val_range
      py = y.to_f64 + height.to_f64 - (normalized_y * height.to_f64)
      {px, py}
    end

    path.move_to(pts[0][0], pts[0][1])

    if smooth && pts.size > 2
      # Catmull-Rom to Cubic Bezier spline smoothing
      1.upto(pts.size - 1) do |i|
        p0 = i > 1 ? pts[i - 2] : pts[i - 1]
        p1 = pts[i - 1]
        p2 = pts[i]
        p3 = i < pts.size - 1 ? pts[i + 1] : pts[i]

        cp1x = p1[0] + (p2[0] - p0[0]) / 6.0
        cp1y = p1[1] + (p2[1] - p0[1]) / 6.0
        cp2x = p2[0] - (p3[0] - p1[0]) / 6.0
        cp2y = p2[1] - (p3[1] - p1[1]) / 6.0

        path.curve_to(cp1x, cp1y, cp2x, cp2y, p2[0], p2[1])
      end
    else
      1.upto(pts.size - 1) do |i|
        path.line_to(pts[i][0], pts[i][1])
      end
    end

    if fill
      # Close along baseline to form area fill
      path.line_to(pts.last[0], y.to_f64 + height.to_f64)
      path.line_to(pts.first[0], y.to_f64 + height.to_f64)
      path.close
    end

    yield path
    self << path
    path
  end

  # Overload for sparkline without customization block
  def sparkline(
    data : Array(Number),
    x : Number,
    y : Number,
    width : Number,
    height : Number,
    stroke : String = "#0284c7",
    stroke_width : Number = 2,
    fill : String? = nil,
    smooth : Bool = false
  ) : Celestine::Path
    sparkline(data, x, y, width, height, stroke, stroke_width, fill, smooth) { }
  end

  # Draws a circular progress ring metric (0.0 to 1.0)
  def progress_ring(
    cx : Number,
    cy : Number,
    radius : Number,
    progress : Number,
    track_color : String = "#e2e8f0",
    fill_color : String = "#3b82f6",
    stroke_width : Number = 8,
    start_angle : Float64 = -90.0,
    &block : Celestine::Group ->
  ) : Celestine::Group
    grp = Celestine::Group.new
    p = progress.to_f64.clamp(0.0, 1.0)

    # Background track circle
    bg = Celestine::Circle.new
    bg.cx = cx
    bg.cy = cy
    bg.radius = radius
    bg.fill = "none"
    bg.stroke = track_color
    bg.stroke_width = stroke_width
    grp << bg

    if p >= 0.9999
      # Full circle indicator
      fg = Celestine::Circle.new
      fg.cx = cx
      fg.cy = cy
      fg.radius = radius
      fg.fill = "none"
      fg.stroke = fill_color
      fg.stroke_width = stroke_width
      grp << fg
    elsif p > 0.001
      # Arc indicator
      deg2rad = ::Math::PI / 180.0
      a1 = start_angle * deg2rad
      a2 = (start_angle + (p * 360.0)) * deg2rad
      r = radius.to_f64

      x1 = cx.to_f64 + (r * ::Math.cos(a1))
      y1 = cy.to_f64 + (r * ::Math.sin(a1))
      x2 = cx.to_f64 + (r * ::Math.cos(a2))
      y2 = cy.to_f64 + (r * ::Math.sin(a2))
      large_arc = p > 0.5

      arc = Celestine::Path.new
      arc.fill = "none"
      arc.stroke = fill_color
      arc.stroke_width = stroke_width
      arc.line_cap = "round"
      arc.move_to(x1, y1)
      arc.arc_to(r, r, rotation: 0, large: large_arc, sweep: true, x: x2, y: y2)
      grp << arc
    end

    yield grp
    self << grp
    grp
  end

  def progress_ring(
    cx : Number,
    cy : Number,
    radius : Number,
    progress : Number,
    track_color : String = "#e2e8f0",
    fill_color : String = "#3b82f6",
    stroke_width : Number = 8,
    start_angle : Float64 = -90.0
  ) : Celestine::Group
    progress_ring(cx, cy, radius, progress, track_color, fill_color, stroke_width, start_angle) { }
  end

  # Draws a donut or pie chart slice
  def donut_slice(
    cx : Number,
    cy : Number,
    r_inner : Number,
    r_outer : Number,
    start_angle : Number,
    end_angle : Number,
    fill : String = "#3b82f6",
    stroke : String? = nil,
    stroke_width : Number = 1,
    &block : Celestine::Path ->
  ) : Celestine::Path
    slice = Celestine::Path.new
    slice.arc_sector(cx, cy, r_inner, r_outer, start_angle, end_angle)
    slice.fill = fill
    slice.stroke = stroke if stroke
    slice.stroke_width = stroke_width if stroke
    yield slice
    self << slice
    slice
  end

  def donut_slice(
    cx : Number,
    cy : Number,
    r_inner : Number,
    r_outer : Number,
    start_angle : Number,
    end_angle : Number,
    fill : String = "#3b82f6",
    stroke : String? = nil,
    stroke_width : Number = 1
  ) : Celestine::Path
    donut_slice(cx, cy, r_inner, r_outer, start_angle, end_angle, fill, stroke, stroke_width) { }
  end
end
