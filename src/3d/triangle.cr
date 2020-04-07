struct Celestine::Three::Triangle
  property p1 : VM::Vec3d = VM::Vec3d.zero
  property p2 : VM::Vec3d = VM::Vec3d.zero
  property p3 : VM::Vec3d = VM::Vec3d.zero

  property color = 0xffffff


  def points
    { p1, p2, p3 }
  end
end

struct Celestine::Three::ProjectedTriangle
  property p1 : VM::Vec2d = VM::Vec2d.zero
  property p2 : VM::Vec2d = VM::Vec2d.zero
  property p3 : VM::Vec2d = VM::Vec2d.zero

  property color = 0xffffff

  def points
    { p1, p2, p3 }
  end
end