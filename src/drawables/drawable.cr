# Basic SVG drawable, inheritted by stuff like circles, rectangles, etc.
abstract class Celestine::Drawable
  # A transform class used to interact with the `transform` attribute
  class Transform
    getter objects_io = IO::Memory.new

    def matrix(a : Number, b : Number, c : Number, d : Number, e : Number, f : Number)
      @objects_io << "matrix(" << a << ' ' << b << ' ' << c << ' ' << d << ' ' << e << ' ' << f << ") "
    end

    def skew_x(x)
      @objects_io << "skewX(" << x << ") "
    end

    def skew_y(y)
      @objects_io << "skewY(" << y << ") "
    end

    def translate(x, y)
      @objects_io << "translate(" << x << ',' << y << ") "
    end

    def rotate(degrees, origin_x = nil, origin_y = nil)
      if origin_x && origin_y
        @objects_io << "rotate(" << degrees << ' ' << origin_x << ' ' << origin_y << ") "
      else
        @objects_io << "rotate(" << degrees << ") "
      end
    end

    def scale(x, y = nil)
      if y
        @objects_io << "scale(" << x << ',' << y << ") "
      else
        @objects_io << "scale(" << x << ") "
      end
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
    if obj_id = @id
      io << "id=\"" << obj_id << "\" "
    end
  end

  # Lazily allocated list of classes for this object
  @classes : Array(String)? = nil

  def classes : Array(String)
    @classes ||= Array(String).new
  end

  def classes=(val : Array(String))
    @classes = val
  end

  # Rendered class options
  def class_attribute(io : IO)
    if cls = @classes
      unless cls.empty?
        io << "class=\""
        cls.join(io, " ")
        io << "\" "
      end
    end
  end

  # Lazily allocated dictionary of inline style options
  @style : Hash(String, String)? = nil

  def style : Hash(String, String)
    @style ||= Hash(String, String).new
  end

  def style=(val : Hash(String, String))
    @style = val
  end

  # Rendered style options
  def style_attribute(io : IO)
    if st = @style
      unless st.empty?
        io << "style=\""
        first = true
        st.each do |k, v|
          io << ' ' unless first
          first = false
          io << k << ':' << v
        end
        io << "\" "
      end
    end
  end

  # Lazily allocated inner elements of this drawable.
  @inner_elements : IO::Memory? = nil

  def inner_elements : IO::Memory
    @inner_elements ||= IO::Memory.new
  end

  def inner_elements=(val : IO::Memory)
    @inner_elements = val
  end

  # Returns true if this drawable has child elements written to its inner buffer
  def has_inner_elements? : Bool
    if ie = @inner_elements
      !ie.empty?
    else
      false
    end
  end

  # Lazily allocated list of custom attributes
  @custom_attrs : Hash(String, String)? = nil

  def custom_attrs : Hash(String, String)
    @custom_attrs ||= Hash(String, String).new
  end

  def custom_attrs=(val : Hash(String, String))
    @custom_attrs = val
  end

  # Rendered custom attributes
  def custom_attribute(io : IO)
    if ca = @custom_attrs
      ca.each do |k, v|
        io << k << "=\"" << v << "\" "
      end
    end
  end

  # Main draw method for a drawable. Takes in and interacts with an io.
  abstract def draw(io : IO) : Nil

  # Serializes this drawable to an IO
  def to_s(io : IO) : Nil
    draw(io)
  end

  # Serializes this drawable to a String
  def to_s : String
    String.build do |io|
      draw(io)
    end
  end
end
