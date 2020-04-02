require "./patches/number.cr"

require "./modules/*"

require "./drawables/drawable"
require "./drawables/circle"
require "./drawables/rectangle"
require "./drawables/path"
require "./drawables/ellipse"
require "./drawables/group"
require "./drawables/use"

require "./effects/animation/animate"
require "./effects/animation/animate_motion"


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
  CLASSES = [Celestine::Circle, Celestine::Rectangle, Celestine::Path, Celestine::Ellipse, Celestine::Group]

  class Context

    alias ViewBox = NamedTuple(x: IFNumber, y: IFNumber, w: IFNumber, h: IFNumber)
    getter objects : Array(Celestine::Drawable) = [] of Celestine::Drawable
    getter defines : Array(Celestine::Drawable) = [] of Celestine::Drawable
    property view_box : ViewBox? = nil
    property width = "100%"
    property height = "100%"
    
    module Methods
      macro included
        {% if @type == Celestine::Meta::Context %}
          {% for klass in Celestine::Meta::CLASSES %}
              make_context_method({{ klass.id }})
          {% end %}
        {% else %}
          {% for klass in Celestine::Meta::CLASSES %}
              make_non_context_method({{ klass.id }})
          {% end %}
        {% end %}
      end

      # Makes context methods specifically for Celestine::Meta::Context
      private macro make_context_method(klass)
        def {{ klass.stringify.split("::").last.downcase.id }}(define = false, &block : Proc({{klass.id}}, Nil))
          {{ klass.stringify.split("::").last.downcase.id }} = {{klass.id}}.new
          yield {{ klass.stringify.split("::").last.downcase.id }}
          if define
            @defines << {{ klass.stringify.split("::").last.downcase.id }}
          else
            @objects << {{ klass.stringify.split("::").last.downcase.id }}
          end
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      private macro make_non_context_method(klass)
        def {{ klass.stringify.split("::").last.downcase.id }}(&block : Proc({{klass.id}}, Nil))
          {{ klass.stringify.split("::").last.downcase.id }} = {{klass.id}}.new
          yield {{ klass.stringify.split("::").last.downcase.id }}
          @objects << {{ klass.stringify.split("::").last.downcase.id }}
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      def use(drawable)
        self.use(drawable) {|g|}
      end

      def use(&block : Celestine::Use -> Nil)
        use = Celestine::Use.new
        yield use
        @objects << use
        use
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

      def <<(drawable : Celestine::Drawable)
        @objects << drawable
        drawable
      end
    end

    include Methods

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
        self.defines.each do |obj|
          s << obj.draw
        end
      s << %Q[</defs>]

      self.objects.each do |obj|
        s << obj.draw
      end

      s << %Q[</svg>]
      s.to_s
    end
  end

  class ::Celestine::Group
    include Celestine::Meta::Context::Methods
  end
end