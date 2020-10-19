# Basic SVG drawable, inheritted by stuff like circles, rectangles, etc. 
abstract struct Celestine::Drawable
  # A transform struct used to interact with the `transform` attribute
  struct Transform
    @objects = [] of String
    def matrix(a : SIFNumber, b : SIFNumber, c : SIFNumber, d : SIFNumber, e : SIFNumber, f : SIFNumber)
      @objects << "matrix(#{a} #{b} #{c} #{d} #{e} #{f})"
    end

    def skew_x(x)
      @objects << "skewX(#{x})"
    end

    def skew_y(y)
      @objects << "skewY(#{y})"
    end

    def translate(x, y)
      @objects << "translate(#{x},#{y})"
    end

    def rotate(degrees, origin_x, origin_y)
      @objects << "rotate(#{degrees} #{origin_x} #{origin_y})"
    end

    def scale(x, y)
      @objects << "scale(#{x},#{y})"
    end

    def to_s
      @objects.join(" ")
    end

    def empty?
      @objects.empty?
    end
  end

  # ID of this object
  property id : String? = nil

  # Render ID options
  def id_options
    if id 
      %Q[id="#{id}" ]
    else
      ""
    end
  end

  # A list of the classes for this object
  property classes : Array(String) = [] of String

  # Rendered class options
  def class_options
    if classes.empty?
      ""
    else
      %Q[class="#{classes.join(" ")}" ]
    end
  end

  # A list of the style options
  property style = {} of String => String

  # Rendered style options
  def style_options
    styles = [] of String
    style.each do |k, v|
      styles << "#{k}:#{v}"
    end

    if styles.empty?
      ""
    else
      %Q[style="#{styles.join(";")}"]
    end
  end

  # A list of custom attributes
  property custom_attrs = {} of String => String

  
  # Rendered custom attributes
  def custom_options
    attrs = [] of String
    custom_attrs.each do |k ,v|
      attrs << %Q[#{k}="#{v}"]
    end
    attrs.join(" ")
  end

  abstract def draw : String
end