class Celestine::Point
  property x : Int32, y : Int32

  OPERATIONS = [:+, :-, :/, :*, :**, :&, :|, :^, :<<, :>>, :%]

  ZERO = Celestine::Point.new(0, 0)

  def initialize(@x, @y)
  end

  {% for op in OPERATIONS %}
    def {{op.id}}(other : Celestine::Point)
      Celestine::Point.new(x {{op.id}} other.x, y {{op.id}} other.y)
    end
  {% end %}

  def to_s(io)
    io << "#{x} #{y}"
  end
end


class Celestine::FPoint
  property x : Float64, y : Float64

  OPERATIONS = [:+, :-, :/, :*]

  ZERO = Celestine::FPoint.new(0.0, 0.0)

  def initialize(x : (Float64 | Float32 | Int32), y : (Float64 | Float32 | Int32))
    @x = x.to_f
    @y = y.to_f
  end

  {% for op in OPERATIONS %}
    def {{op.id}}(other : Celestine::FPoint)
      Celestine::FPoint.new(x {{op.id}} other.x, y {{op.id}} other.y)
    end
  {% end %}

  def to_s(io)
    io << "#{x} #{y}"
  end
end