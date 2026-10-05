# Algorithmic hand-drawn sketchy vector generator for Celestine
# Generates organic, sketchy multi-pass paths with deterministic jitter and bowing.
class Celestine::Rough
  property roughness : Float64
  property bowing : Float64
  property passes : Int32
  property max_random_offset : Float64
  property rng : Random::PCG32

  def initialize(
    @roughness : Float64 = 1.0,
    @bowing : Float64 = 1.0,
    @passes : Int32 = 2,
    @max_random_offset : Float64 = 2.0,
    seed : UInt64 = 42_u64
  )
    @rng = Random::PCG32.new(seed)
  end

  private def rand_offset(max_val : Float64) : Float64
    (@rng.rand * 2.0 - 1.0) * max_val * @roughness
  end

  # Adds a sketchy line between (x1, y1) and (x2, y2) to the given path
  def line(path : Celestine::Path, x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Nil
    dx = (x2 - x1).to_f64
    dy = (y2 - y1).to_f64
    len = ::Math.sqrt(dx * dx + dy * dy)
    return if len < 0.001

    nx = -dy / len
    ny = dx / len

    @passes.times do
      # Endpoints with jitter and slight overshoot
      overshoot = rand_offset(@max_random_offset * 1.5)
      sx = x1.to_f64 + rand_offset(@max_random_offset) - (dx / len * overshoot * 0.5)
      sy = y1.to_f64 + rand_offset(@max_random_offset) - (dy / len * overshoot * 0.5)
      ex = x2.to_f64 + rand_offset(@max_random_offset) + (dx / len * overshoot * 0.5)
      ey = y2.to_f64 + rand_offset(@max_random_offset) + (dy / len * overshoot * 0.5)

      # Midpoint bowing control point
      bow = rand_offset(@bowing * @max_random_offset * 1.2)
      cx = (x1 + x2) / 2.0 + (nx * bow)
      cy = (y1 + y2) / 2.0 + (ny * bow)

      path.move_to(sx, sy)
      path.quad_to(cx, cy, ex, ey)
    end
  end

  # Adds a sketchy rectangle to the given path
  def rect(path : Celestine::Path, x : Number, y : Number, width : Number, height : Number) : Nil
    x1 = x.to_f64
    y1 = y.to_f64
    x2 = x1 + width.to_f64
    y2 = y1 + height.to_f64

    line(path, x1, y1, x2, y1) # top
    line(path, x2, y1, x2, y2) # right
    line(path, x2, y2, x1, y2) # bottom
    line(path, x1, y2, x1, y1) # left
  end

  # Adds a sketchy circle centered at (cx, cy) with radius r to the given path
  def circle(path : Celestine::Path, cx : Number, cy : Number, r : Number) : Nil
    return if r <= 0
    rad = r.to_f64
    center_x = cx.to_f64
    center_y = cy.to_f64

    # Render multi-pass overlapping sketched circles
    @passes.times do
      points_count = 8
      angle_step = (::Math::PI * 2.0) / points_count
      pts = Array(Tuple(Float64, Float64)).new(points_count + 1)

      (points_count + 1).times do |i|
        angle = i * angle_step
        r_jitter = rad + rand_offset(@max_random_offset * 1.2)
        px = center_x + (r_jitter * ::Math.cos(angle))
        py = center_y + (r_jitter * ::Math.sin(angle))
        pts << {px, py}
      end

      # Draw smoothed path around vertices
      path.move_to(pts[0][0], pts[0][1])
      1.upto(points_count) do |i|
        curr = pts[i]
        prev = pts[i - 1]
        mid_x = (prev[0] + curr[0]) / 2.0
        mid_y = (prev[1] + curr[1]) / 2.0
        path.quad_to(prev[0], prev[1], mid_x, mid_y)
      end
      path.line_to(pts.last[0], pts.last[1])
    end
  end

  # Adds a sketchy polygon connecting the points
  def polygon(path : Celestine::Path, points : Array(Tuple(IFNumber, IFNumber)) | Array(Celestine::Point) | Array(Celestine::FPoint)) : Nil
    return if points.size < 2

    points.each_with_index do |p1, idx|
      p2 = points[(idx + 1) % points.size]
      x1 = p1.is_a?(Tuple) ? p1[0] : p1.x
      y1 = p1.is_a?(Tuple) ? p1[1] : p1.y
      x2 = p2.is_a?(Tuple) ? p2[0] : p2.x
      y2 = p2.is_a?(Tuple) ? p2[1] : p2.y
      line(path, x1, y1, x2, y2)
    end
  end

  # Fluent builder adapter combining Rough engine with a Path
  class Builder
    getter rough : Celestine::Rough
    getter path : Celestine::Path

    def initialize(@rough : Celestine::Rough, @path : Celestine::Path)
    end

    def line(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : self
      @rough.line(@path, x1, y1, x2, y2)
      self
    end

    def rect(x : Number, y : Number, width : Number, height : Number) : self
      @rough.rect(@path, x, y, width, height)
      self
    end

    def circle(cx : Number, cy : Number, r : Number) : self
      @rough.circle(@path, cx, cy, r)
      self
    end

    def polygon(points : Array(Tuple(IFNumber, IFNumber)) | Array(Celestine::Point) | Array(Celestine::FPoint)) : self
      @rough.polygon(@path, points)
      self
    end
  end
end
