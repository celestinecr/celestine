# Embeds CSS stylesheets inside an SVG document
#
# * [Mozilla SVG Docs](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/style)
class Celestine::Style < Celestine::Drawable
  TAG = "style"

  property type : String = "text/css"
  getter rules : Array(String) = [] of String

  def initialize(@type : String = "text/css")
  end

  # Adds a raw CSS string to this stylesheet
  def css(raw_css : String) : self
    @rules << raw_css
    self
  end

  # Adds a formatted CSS rule with a selector and properties
  #
  # ```
  # style.rule(".icon", fill: "#3b82f6", stroke_width: "2px")
  # ```
  def rule(selector : String, **props) : self
    css_rule = String.build do |io|
      io << selector << " {\n"
      props.each do |key, value|
        prop_name = key.to_s.gsub('_', '-')
        io << "  " << prop_name << ": " << value << ";\n"
      end
      io << "}"
    end
    @rules << css_rule
    self
  end

  def draw(io : IO) : Nil
    io << '<' << TAG
    io << %Q[ type="#{type}"] unless type.empty?
    draw_attributes(io)
    io << '>'

    unless @rules.empty?
      io << "\n"
      @rules.each do |r|
        io << r << "\n"
      end
    end

    if has_inner_elements?
      io << inner_elements
    end

    io << "</" << TAG << '>'
  end
end
