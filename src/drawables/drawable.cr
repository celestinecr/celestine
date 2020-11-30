# Basic SVG drawable, inheritted by stuff like circles, rectangles, etc. 
abstract class Celestine::Drawable
  # A transform class used to interact with the `transform` attribute
  class Transform
    getter objects_io = IO::Memory.new
    def matrix(a : Float64, b : Float64, c : Float64, d : Float64, e : Float64, f : Float64)
      @objects_io << "matrix(#{a} #{b} #{c} #{d} #{e} #{f}) "
    end

    def skew_x(x)
      @objects_io << "skewX(#{x}) "
    end

    def skew_y(y)
      @objects_io << "skewY(#{y}) "
    end

    def translate(x, y)
      @objects_io << "translate(#{x},#{y}) "
    end

    def rotate(degrees, origin_x, origin_y)
      @objects_io << "rotate(#{degrees} #{origin_x} #{origin_y}) "
    end

    def scale(x, y)
      @objects_io << "scale(#{x},#{y}) "
    end

    def to_s 
      @objects_io.to_s
    end

    def empty?
      @objects_io.empty?
    end
  end

  # ID of this object
  property id : String? = nil

  # Render ID options
  def id_attribute(io : IO)
    if id 
      io << %Q[id="#{id}" ]
    end
  end

  # A list of the classes for this object
  # TODO: Fix this by making it a string or class type
  property classes : Array(String) = [] of String

  # def add_class(new_class)
  #   classes = "#{classes} #{new_class}"
  # end

  # Rendered class options
  def class_attribute(io : IO)
    unless classes.empty?
      io << %Q[class="]
      classes.join(io, " ")
      io << %Q[" ]
    end
  end

  # A list of the style options
  # TODO: Fix this by making it a string or class type
  property style = {} of String => String

  # Rendered style options
  def style_attribute(io : IO)
    unless style.empty?
      io << %Q[style="]
      style.keys.map { |k| "#{k}:#{style[k]}" }.join(io, " ")
      io << %Q[" ]
    end
  end

  # The inner elements of this drawable.
  # TODO: Fix this by making it a string or class type
  property inner_elements = IO::Memory.new

  # A list of custom attributes
  # TODO: Change this to work with Int and Floats? Doesn't this need to be `String => Float64`?
  # TODO: Fix this by making it a string or class type
  property custom_attrs = {} of String => String

  
  # Rendered custom attributes
  def custom_attribute(io : IO)
    custom_attrs.keys.map { |k| %Q[#{k}="#{custom_attrs[k]}"] }.join(io, " ")
    io << " "
  end

  # Main draw method for a drawable. Takes in and interacts with an io.
  abstract def draw(io : IO) : Nil
end