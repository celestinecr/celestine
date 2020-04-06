module Celestine::Collision
  def self.check?(obj : Celestine::Drawable, point : Celestine::Point) : Bool
    if obj.is_a?(Celestine::Rectangle)
      rect_vs_point?(obj.as(Celestine::Rectangle), point)
    else
      raise "Shape does not have collision yet, sorry :("
    end
  end

  def self.check?(objs : Array(Celestine::Drawable), point : Celestine::Point) : Bool
    objs.any? do |obj|
      if obj.is_a?(Celestine::Rectangle)
        rect_vs_point?(obj.as(Celestine::Rectangle), point)
      else
        raise "Shape does not have collision yet, sorry :("
      end
    end
  end

  def self.check?(obj : Celestine::Drawable, point : Celestine::FPoint) : Bool
    if obj.is_a?(Celestine::Rectangle)
      rect_vs_fpoint?(obj.as(Celestine::Rectangle), point)
    else
      raise "Shape does not have collision yet, sorry :("
    end
  end

  def self.check?(objs : Array(Celestine::Drawable), point : Celestine::FPoint) : Bool
    objs.any? do |obj|
      if obj.is_a?(Celestine::Rectangle)
        rect_vs_fpoint?(obj.as(Celestine::Rectangle), point)
      else
        raise "Shape does not have collision yet, sorry :("
      end
    end
  end

  def self.check?(obj1 : Celestine::Drawable, obj2 : Celestine::Drawable) : Bool
    if obj1.is_a?(Celestine::Rectangle) && obj2.is_a?(Celestine::Rectangle)
      rect_vs_rect?(obj1.as(Celestine::Rectangle), obj2.as(Celestine::Rectangle))
    else
      raise "Shape does not have collision yet, sorry :("
    end
  end

  def self.check?(obj : Celestine::Drawable, others : Array(Celestine::Drawable)) : Bool
    others.any? {|o| check?(obj, o)}
  end

  def self.check?(objs : Array(Celestine::Drawable), others : Array(Celestine::Drawable)) : Bool
    others.any? {|o| objs.any? {|obj| check?(obj, o) } }
  end

  def self.rect_vs_rect?(a : Celestine::Rectangle, b : Celestine::Rectangle) : Bool
    # TODO: CHECK TRANSFORM PARAMS FOR REAL DETECTION
    !(a.right < b.left || a.left > b.right) && !(a.bottom < b.top || a.top > b.bottom)
  end

  def self.rect_vs_point?(a : Celestine::Rectangle, point : Celestine::Point) : Bool
    # TODO: CHECK TRANSFORM PARAMS FOR REAL DETECTION
    !(a.right < point.x || a.left >point.x) && !(a.bottom < point.y|| a.top > point.y)
  end

  def self.rect_vs_fpoint?(a : Celestine::Rectangle, point : Celestine::FPoint) : Bool
    # TODO: CHECK TRANSFORM PARAMS FOR REAL DETECTION
    !(a.right < point.x || a.left >point.x) && !(a.bottom < point.y|| a.top > point.y)
  end
end