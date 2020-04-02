abstract class Celestine::Drawable
  class Transform
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

  property id : String? = nil
  def id_options
    if id 
      %Q[id="#{id}" ]
    else
      ""
    end
  end

  property classes : Array(String) = [] of String
  def class_options
    if classes.empty?
      ""
    else
      %Q[class="#{classes.join(" ")}" ]
    end
  end

  property style = {} of String => String
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


  abstract def draw : String
end