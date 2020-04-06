require "./point"
module Celestine::Math
  def self.rotate_point(x, y, ox, oy, deg) : Celestine::FPoint
    angle = deg * (::Math::PI/180)
    rx = ::Math.cos(angle) * (x - ox) - ::Math.sin(angle) * (y - oy) + ox
    ry = ::Math.sin(angle) * (x - ox) + ::Math.cos(angle) * (y - oy) + oy
    Celestine::FPoint.new(x: rx, y: ry)
  end

  def self.rotate_point(point : (Celestine::FPoint | Celestine::Point), origin : (Celestine::FPoint | Celestine::Point), deg) : Celestine::FPoint
    angle = deg * (::Math::PI/180)
    rx = ::Math.cos(angle) * (point.x - origin.x) - ::Math.sin(angle) * (point.y - origin.y) + origin.x
    ry = ::Math.sin(angle) * (point.x - origin.x) + ::Math.cos(angle) * (point.y - origin.y) + origin.y
    Celestine::FPoint.new(x: rx, y: ry)
  end
end