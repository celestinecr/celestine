require "./patches/number.cr"

require "./modules/*"

require "./drawables/drawable"
require "./drawables/circle"
require "./drawables/rectangle"
require "./drawables/path"
require "./drawables/ellipse"
require "./drawables/group"

require "./effects/animation/animate"

alias IFNumber = (Float64 | Int32)
alias SIFNumber = (IFNumber | String)

module Celestine

  def self.draw(&block : Proc(Celestine::Meta::Context, Nil))
    ctx = Celestine::Meta::Context.new
    yield ctx
    ctx.render
  end
end

module Celestine::Meta
  class Context
    alias ViewBox = NamedTuple(x: IFNumber, y: IFNumber, w: IFNumber, h: IFNumber)
    getter objects : Array(Celestine::Drawable) = [] of Celestine::Drawable
    getter defines : Array(Celestine::Drawable) = [] of Celestine::Drawable
    property view_box : ViewBox? = nil
    property width = "100%"
    property height = "100%"

    def circle(define = false, &block : Proc(Celestine::Circle, Nil))
      circle = Celestine::Circle.new
      yield circle
      if define
        @defines << circle
      else
        @objects << circle
      end
      circle
    end

    def rectangle(define = false, &block : Proc(Celestine::Rectangle, Nil))
      rectangle = Celestine::Rectangle.new
      yield rectangle
      if define
        @defines << rectangle
      else
        @objects << rectangle
      end
      rectangle
    end

    def path(define = false, &block : Proc(Celestine::Path, Nil))
      path = Celestine::Path.new
      yield path
      if define
        @defines << path
      else
        @objects << path
      end
      path
    end

    def ellipse(define = false, &block : Proc(Celestine::Ellipse, Nil))
      ellipse = Celestine::Ellipse.new
      yield ellipse
      if define
        @defines << ellipse
      else
        @objects << ellipse
      end
      ellipse
    end

    def group(define = false, &block : Proc(Celestine::Group, Nil))
      group = Celestine::Group.new
      yield group
      if define
        @defines << group
      else
        @objects << group
      end
      group
    end

    def render
      s = String::Builder.new
      xmlns = %Q[xmlns="http://www.w3.org/2000/svg"]      
      view_box_option = ""
      if self.view_box
        vb = self.view_box.as(ViewBox)
        view_box_option = %Q[viewBox="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}"]
        s << %Q[<svg #{view_box_option} height="100%" width="100%" #{xmlns}>]
      else
        s << %Q[<svg width="#{width}" height="#{height}" #{xmlns}>]
      end

      
      s << %Q[<defs>]
      s << %Q[</defs>]

      self.objects.each do |obj|
        s << obj.draw
      end

      s << %Q[</svg>]
      s.to_s
    end
  end
end