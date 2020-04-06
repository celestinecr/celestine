struct Celestine::Three::Triangle
  property p1 = VM::Vec3f.zero
  property p2 = VM::Vec3f.zero
  property p3 = VM::Vec3f.zero


  def points
    { p1, p2, p3 }
  end
end

struct Celestine::Three::ProjectedTriangle
  property p1, p2, p3 : VM::Vec2f = VM::Vec2f.zero

  def points
    { p1, p2, p3 }
  end
end