class Celestine::Group < Celestine::Drawable
  include Celestine::Modules::Transform
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  

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

  def use(drawable : Celestine::Drawable)
    self.use(drawable) {|g|}
  end

  def use(drawable : Celestine::Drawable, &block : Proc(Celestine::Use, Nil))
    use = Celestine::Use.new
    if drawable.id
      use.target_id = drawable.id.to_s
      yield use
      @objects << use
      use
    else
      raise "Reused objects must have an id assigned"
    end
  end

  def use(id : String, &block : Proc(Celestine::Use, Nil))
    use = Celestine::Use.new
    if drawable.id
      use.target_id = id
      yield use
      @objects << use
      use
    else
      raise "Reused objects must have an id assigned"
    end
  end

  def draw
    s = String::Builder.new
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?

    
    s << %Q[<g #{options.join(" ")}>]
    s << animate_tags
    s << animate_motion_tags



    @objects.each do |drawable|
      s << drawable.draw
    end
    s << %Q[</g>]

    s.to_s
  end
end