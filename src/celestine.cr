require "./patches/number.cr"

require "./modules/position"
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
require "./effects/mask"

require "./collision/helpers"


# Special alias for HTML attribute parameters. Since many attributes can be either FLOAT or INT
alias IFNumber = (Float64 | Int32)
# Special alias for HTML attribute parameters. Some attributes take numbers or strings, such as 10, 100%, or 100px
alias SIFNumber = (IFNumber | String)

# Main module for Celestine
module Celestine
  # Main draw function for DSL
  def self.draw(&block : Proc(Celestine::Meta::Context, Nil))
    ctx = Celestine::Meta::Context.new
    yield ctx
    ctx.render
  end
end

# Modules where all DSL and Meta code is held
module Celestine::Meta
  # List of classes we want context methods for (such as circle, rectangle, etc)
  CLASSES = [Celestine::Circle, Celestine::Rectangle, Celestine::Path, Celestine::Ellipse, Celestine::Group, Celestine::Image]

  # Hold context information for the DSL
  class Context

    # Alias for the viewBox SVG parameter
    alias ViewBox = NamedTuple(x: IFNumber, y: IFNumber, w: IFNumber, h: IFNumber)
    # Objects to be drawn to the scene
    getter objects : Array(Celestine::Drawable) = [] of Celestine::Drawable
    # Objects in the defs section, which can be used by ID
    getter defines : Array(Celestine::Drawable) = [] of Celestine::Drawable
    # The viewBox of the SVG scene
    property view_box : ViewBox? = nil
    property width = "100%"
    property height = "100%"

    property shape_rendering = "auto"
    
    # Holds all the context methods to be included in DSL classes like Context, Group, and Mask
    module Methods
      macro included
        # Only add these methods if this is a Context
        {% if @type == Celestine::Meta::Context %}
          {% for klass in Celestine::Meta::CLASSES %}
              make_context_method({{ klass.id }})
          {% end %}

          def define(drawable : Celestine::Drawable)
            @defines << drawable
            drawable
          end

          def mask(&block : Celestine::Mask -> Celestine::Mask)
            mask = yield Celestine::Mask.new
            @defines << mask
            mask
          end
        # Adds methods without the define parameter.
        {% else %}
          {% for klass in Celestine::Meta::CLASSES %}
              make_non_context_method({{ klass.id }})
          {% end %}
        {% end %}
      end

      # Makes context methods specifically for Celestine::Meta::Context
      private macro make_context_method(klass)
        def {{ klass.stringify.split("::").last.downcase.id }}(define = false, &block : {{klass.id}} -> {{klass.id}}) : {{klass.id}}
          {{ klass.stringify.split("::").last.downcase.id }} = yield {{klass.id}}.new
          if define
            @defines << {{ klass.stringify.split("::").last.downcase.id }}
          else
            @objects << {{ klass.stringify.split("::").last.downcase.id }}
          end
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      # Makes context methods for classes without a defs collection.
      private macro make_non_context_method(klass)
        def {{ klass.stringify.split("::").last.downcase.id }}(&block : {{klass.id}} -> {{klass.id}}) : {{klass.id}}
          {{ klass.stringify.split("::").last.downcase.id }} = yield {{klass.id}}.new
          @objects << {{ klass.stringify.split("::").last.downcase.id }}
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      def use(id : String)
        self.use(id) {|g| g }
      end

      def use(drawable : Celestine::Drawable)
        self.use(drawable) {|g| g }
      end

      def use(&block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        use = yield use
        @objects << use
        use
      end

      def use(drawable : Celestine::Drawable, &block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        if drawable.id
          use.target_id = drawable.id.to_s
          use = yield use
          @objects << use
          use
        else
          raise "Reused objects must have an id assigned"
        end
      end

      def use(id : String, &block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        use.target_id = id
        use = yield use
        @objects << use
        use
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
        s << %Q[<svg #{shape_rendering != "auto" ? "shape-rendering=\"#{shape_rendering}\" " : ""} #{view_box_option} height="100%" width="100%" #{xmlns}>]
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

  struct ::Celestine::Group
    include Celestine::Meta::Context::Methods
  end

  struct ::Celestine::Mask
    include Celestine::Meta::Context::Methods
  end
end