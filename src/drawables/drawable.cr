abstract class Celestine::Drawable
  class Transform
    @objects = String::Builder.new

    def matrix(a : SIFNumber, b : SIFNumber, c : SIFNumber, d : SIFNumber, e : SIFNumber, f : SIFNumber)
      @objects << "matrix(#{a}, #{b}, #{c}, #{d}, #{e}, #{f}) "
    end

    def skew_x(x)
      @objects << "skewX(#{x}) "
    end

    def skew_y(y)
      @objects << "skewY(#{y}) "
    end

    def translate(x, y)
      @objects << "translate(#{x}, #{y}) "
    end

    def rotate(degrees, origin_x, origin_y)
      @objects << "rotate(#{degrees}, #{origin_x}, #{origin_y}) "
    end

    def scale(x, y)
      @objects << "scale(#{x}, #{y}) "
    end

    def to_s
      @objects.to_s
    end

    def empty?
      @objects.empty?
    end
  end

  abstract def draw : String

  getter transform_options : String? = nil

  def transform(&block : Proc(Celestine::Drawable::Transform, Nil))
    meta = Celestine::Drawable::Transform.new
    yield meta

    if !meta.empty?
      @transform_options = %Q[transform="#{meta.to_s}"]
    end
  end
end