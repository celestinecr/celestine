class Celestine::Group < Celestine::Drawable
  include Celestine::Modules::Transform
  include Celestine::Modules::StrokeFill

  @objects = [] of Celestine::Drawable


  property? override_stroke_fill = false
  def circle(&block : Proc(Celestine::Circle, Nil))
    circle = Celestine::Circle.new
    yield circle
    @objects << circle
    circle
  end

  def rectangle(block : Proc(Celestine::Rectangle, Nil))
    rectangle = Celestine::Rectangle.new
    yield rectangle
    @objects << rectangle
    rectangle
  end

  def path(&block : Proc(Celestine::Path, Nil))
    path = Celestine::Path.new
    yield path
    @objects << path
    path
  end

  def ellipse(&block : Proc(Celestine::Ellipse, Nil))
    ellipse = Celestine::Ellipse.new
    yield ellipse
    @objects << ellipse
    ellipse
  end

  def group(&block : Proc(Celestine::Ellipse, Nil))
    group = Celestine::Ellipse.new
    yield group
    @objects << group
    group
  end

  def draw
    s = String::Builder.new
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    s << %Q[<g #{options.join(" ")}>]
    @objects.each do |drawable|
      s << drawable.draw
    end
    s << %Q[</g>]

    s.to_s
  end
end