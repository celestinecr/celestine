class Celestine::Point
  property x : Int32, y : Int32

  OPERATIONS = [:+, :-, :*, :**, :&, :|, :^, :<<, :>>, :%]

  ZERO = Celestine::Point.new(0, 0)

  def initialize(@x : Int32, @y : Int32)
  end

  {% for op in OPERATIONS %}
    def {{op.id}}(other : Celestine::Point)
      Celestine::Point.new(x {{op.id}} other.x, y {{op.id}} other.y)
    end
  {% end %}

  # Floating-point division returns an FPoint
  def /(other : Celestine::Point) : Celestine::FPoint
    Celestine::FPoint.new(x / other.x, y / other.y)
  end

  # Integer division returns a Point
  def //(other : Celestine::Point) : Celestine::Point
    Celestine::Point.new(x // other.x, y // other.y)
  end

  def *(scalar : Number) : Celestine::Point
    Celestine::Point.new(x * scalar, y * scalar)
  end

  def /(scalar : Number) : Celestine::FPoint
    Celestine::FPoint.new(x / scalar, y / scalar)
  end

  def //(scalar : Number) : Celestine::Point
    Celestine::Point.new(x // scalar, y // scalar)
  end

  def ==(other : Celestine::Point) : Bool
    x == other.x && y == other.y
  end

  def to_s(io)
    io << "#{x} #{y}"
  end
end

class Celestine::FPoint
  property x : Float64, y : Float64

  OPERATIONS = [:+, :-, :/, :*]

  ZERO = Celestine::FPoint.new(0.0, 0.0)

  def initialize(x : Number, y : Number)
    @x = x.to_f
    @y = y.to_f
  end

  {% for op in OPERATIONS %}
    def {{op.id}}(other : Celestine::FPoint)
      Celestine::FPoint.new(x {{op.id}} other.x, y {{op.id}} other.y)
    end
  {% end %}

  def *(scalar : Number) : Celestine::FPoint
    Celestine::FPoint.new(x * scalar, y * scalar)
  end

  def /(scalar : Number) : Celestine::FPoint
    Celestine::FPoint.new(x / scalar, y / scalar)
  end

  def ==(other : Celestine::FPoint) : Bool
    (x - other.x).abs < 1e-9 && (y - other.y).abs < 1e-9
  end

  def to_s(io)
    io << "#{x} #{y}"
  end
end
