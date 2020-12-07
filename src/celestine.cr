require "myhtml"

require "./patches/number"
require "./macros/**"

require "./modules/position"
require "./modules/*"

require "./drawables/drawable"
require "./drawables/anchor"
require "./drawables/circle"
require "./drawables/rectangle"
require "./drawables/path"
require "./drawables/ellipse"
require "./drawables/group"
require "./drawables/use"
require "./drawables/text"
require "./drawables/image"

require "./effects/animation/animate"
require "./effects/animation/animate_motion"
require "./effects/animation/transform/rotate"

require "./effects/mask"
require "./effects/filter"
require "./effects/filters/basic"
require "./effects/filters/**"
require "./effects/marker"

require "./math/**"

alias IFNumber = (Int32 | Float64)
alias SIFNumber = (String | IFNumber)


# Main module for Celestine
module Celestine
  VERSION = "0.6.0alpha"

  # Main draw function for DSL
  def self.draw(&block : Proc(Celestine::Meta::Context, Nil)) : String
    String.build do |io|
      self.draw io, &block
    end
  end

  def self.draw(io : IO, &block : Proc(Celestine::Meta::Context, Nil)) : IO
    ctx = Celestine::Meta::Context.new
    yield ctx
    ctx.render(io)
  end
end

# Modules where all DSL and Meta code is held
module Celestine::Meta
  # List of classes we want context methods for (such as circle, rectangle, etc). If you need to add a new drawable to Celestine you must add it here as well.
  CLASSES = [Celestine::Circle, Celestine::Rectangle, Celestine::Path, Celestine::Ellipse, Celestine::Group, Celestine::Image, Celestine::Text, Celestine::Anchor]


  # Hold context information for the DSL
  class Context
    # Alias for the viewBox SVG parameter
    alias ViewBox = NamedTuple(x: IFNumber, y: IFNumber, w: IFNumber, h: IFNumber)
    # Objects to be drawn to the scene
    getter objects_io = IO::Memory.new
    # Objects in the defs section, which can be used by ID
    getter defines_io = IO::Memory.new
    # The viewBox of the SVG scene
    property view_box : ViewBox? = nil
    property width : Float64 = 100
    property width_units : String = "%"
    property height : Float64 = 100
    property height_units : String = "%"

    property shape_rendering = "auto"

    # Holds all the context methods to be included in DSL classes like Context, Group, and Mask.
    # This creates all the methods that can be used inside the draw block, like `circle` or `group` or `use`.
    module Methods
      macro included
        {% if @type == Celestine::Meta::Context %}
          # Go through each class in CLASSES and lowercase the last part to make a method name.
          {% for klass in Celestine::Meta::CLASSES %}
              make_context_method({{ klass.id }})
          {% end %}

          # Add `drawable` to this `Celestine::Meta::Context`'s definitions, allowing it to be `use`d later.
          def define(drawable : Celestine::Drawable)
            drawable.draw(@defines_io)
            drawable
          end

          # Create a mask object and add it to this `Celestine::Meta::Context`
          def mask(&block : Celestine::Mask -> Celestine::Mask)
            mask = yield Celestine::Mask.new
            define(mask)
            mask
          end

          # Create a mask object and add it to this `Celestine::Meta::Context`
          def marker(&block : Celestine::Marker -> Celestine::Marker)
            marker = yield Celestine::Marker.new
            define(marker)
            marker
          end

          # Create a mask object and add it to this `Celestine::Meta::Context`
          def filter(&block : Celestine::Filter -> Celestine::Filter)
            filter = yield Celestine::Filter.new
            define(filter)
            filter
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
        # Allows a `{{klass.id}}` to be made using a DSL call. Can be defined, which adds the drawable to the main context's definitions, and not to the main document itself.
        def {{ klass.stringify.split("::").last.downcase.id }}(define = false, &block : {{klass.id}} -> {{klass.id}}) : {{klass.id}}
          {{ klass.stringify.split("::").last.downcase.id }} = yield {{klass.id}}.new
          if define
            define({{ klass.stringify.split("::").last.downcase.id }})
          else
            self << {{ klass.stringify.split("::").last.downcase.id }}
          end
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      # Makes context methods for classes without a defs collection.
      private macro make_non_context_method(klass)
        # Allows a `{{klass.id}}` to be made using a DSL call, and added to this drawables items.
        def {{ klass.stringify.split("::").last.downcase.id }}(&block : {{klass.id}} -> {{klass.id}}) : {{klass.id}}
          {{ klass.stringify.split("::").last.downcase.id }} = yield {{klass.id}}.new
          self << {{ klass.stringify.split("::").last.downcase.id }}
          {{ klass.stringify.split("::").last.downcase.id }}
        end
      end

      # Reuses an element defined using `define: true` by id
      def use(id : String)
        self.use(id) { |g| g }
      end

      # Reuses an element defined using `define: true`
      def use(drawable : Celestine::Drawable)
        self.use(drawable) { |g| g }
      end

      # Reuses an element defined using `define: true` and then opens a block with that object for configuring
      def use(&block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        use = yield use
        self << use
        use
      end

      # Reuses an element defined using `define: true` and then opens a block with that object for configuring
      def use(drawable : Celestine::Drawable, &block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        if drawable.id
          use.target_id = drawable.id.to_s
          use = yield use
          self << use
          use
        else
          raise "Reused objects must have an id assigned"
        end
      end

      # Reuses an element defined using `define: true` by id and then opens a block with that object for configuring
      def use(id : String, &block : Celestine::Use -> Celestine::Use)
        use = Celestine::Use.new
        use.target_id = id
        use = yield use
        self << use
        use
      end

      # Adds a new drawable to this context's objects
      def <<(drawable : Celestine::Drawable)
        drawable.draw(@objects_io)
        drawable
      end
    end

    include Methods

    # Takes all the objects and renders them to a string SVG
    def render(io : IO)
      xmlns = %Q[xmlns="http://www.w3.org/2000/svg"]
      view_box_option = ""
      if self.view_box
        vb = self.view_box.as(ViewBox)
        view_box_option = %Q[viewBox="#{vb[:x]} #{vb[:y]} #{vb[:w]} #{vb[:h]}"]
        io << %Q[<svg #{shape_rendering != "auto" ? "shape-rendering=\"#{shape_rendering}\" " : ""}#{view_box_option} width="#{width}#{width_units}" height="#{height}#{height_units}" #{xmlns}>]
      else
        io << %Q[<svg width="#{width}#{width_units}" height="#{height}#{height_units}" #{xmlns}>]
      end

      unless @defines_io.empty?
        io << %Q[<defs>]
        io << @defines_io
        io << %Q[</defs>]
      end
      io << @objects_io

      io << %Q[</svg>]
    end
  end

  # Group class which can group multiple drawables together.
  class ::Celestine::Group
    include Celestine::Meta::Context::Methods
  end

    # Group class which can group multiple drawables together.
    class ::Celestine::Anchor
      include Celestine::Meta::Context::Methods
    end
  

  # Class which acts like a group, but applies masking to another drawable.
  class ::Celestine::Mask
    include Celestine::Meta::Context::Methods
  end

  # Class which acts like a group, but applies masking to another drawable.
  class ::Celestine::Marker
    include Celestine::Meta::Context::Methods
  end
end
