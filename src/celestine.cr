require "myhtml"

require "./patches/number"
require "./macros/**"

require "./modules/position"
require "./modules/*"

require "./drawables/drawable"
require "./drawables/svg"
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
require "./effects/pattern"
require "./effects/gradients/gradient"
require "./effects/gradients/**"

require "./math/**"

alias IFNumber = (Int32 | Float64)
alias SIFNumber = (String | IFNumber)


# Main module for Celestine
module Celestine
  alias ViewBox = NamedTuple(x: IFNumber, y: IFNumber, w: IFNumber, h: IFNumber)
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  # Main draw function for DSL
  def self.draw(&block : Proc(Celestine::Svg, Nil)) : String
    String.build do |io|
      self.draw io, &block
    end
  end

  def self.draw(io : IO, &block : Proc(Celestine::Svg, Nil)) : IO
    ctx = Celestine::Svg.new
    yield ctx
    ctx.draw(io)
    io
  end
end

# Modules where all DSL and Meta code is held
module Celestine::Meta
  # List of classes we want context methods for (such as circle, rectangle, etc). If you need to add a new drawable to Celestine you must add it here as well.
  CLASSES = [Celestine::Svg, Celestine::Circle, Celestine::Rectangle, Celestine::Path, Celestine::Ellipse, Celestine::Group, Celestine::Image, Celestine::Text, Celestine::Anchor]


  # Hold context information for the DSL
  module Context
    # Holds all the context methods to be included in DSL classes like Context, Group, and Mask.
    # This creates all the methods that can be used inside the draw block, like `circle` or `group` or `use`.
    module Methods
      macro included
        {% if @type == Celestine::Svg %}
          # Go through each class in CLASSES and lowercase the last part to make a method name.
          {% for klass in Celestine::Meta::CLASSES %}
              make_context_method({{ klass.id }})
          {% end %}

          # Add `drawable` to this `Celestine::Svg`'s definitions, allowing it to be `use`d later.
          def define(drawable : Celestine::Drawable)
            drawable.draw(@defines_io)
            drawable
          end

          # Create a mask object and add it to this `Celestine::Svg`'s defs
          def mask(&block : Celestine::Mask -> Celestine::Mask)
            mask = yield Celestine::Mask.new
            define(mask)
            mask
          end

          # Create a marker object and add it to this `Celestine::Svg`'s defs
          def marker(&block : Celestine::Marker -> Celestine::Marker)
            marker = yield Celestine::Marker.new
            define(marker)
            marker
          end

          # Create a filter object and add it to this `Celestine::Svg`'s defs
          def filter(&block : Celestine::Filter -> Celestine::Filter)
            filter = yield Celestine::Filter.new
            define(filter)
            filter
          end

          # Create a pattern object and add it to this `Celestine::Svg`'s defs
          def pattern(&block : Celestine::Pattern -> Celestine::Pattern)
            pattern = yield Celestine::Pattern.new
            define(pattern)
            pattern
          end

          # Create a linear gradient object and add it to this `Celestine::Svg`'s defs
          def linear_gradient(&block : Celestine::Gradient::Linear -> Celestine::Gradient::Linear)
            linear = yield Celestine::Gradient::Linear.new
            define(linear)
            linear
          end

          # Create a linear gradient object and add it to this `Celestine::Svg`'s defs
          def radial_gradient(&block : Celestine::Gradient::Radial -> Celestine::Gradient::Radial)
            radial = yield Celestine::Gradient::Radial.new
            define(radial)
            radial
          end

        # Adds methods without the define parameter.
        {% else %}
          {% for klass in Celestine::Meta::CLASSES %}
              make_non_context_method({{ klass.id }})
          {% end %}
        {% end %}
      end

      # Makes context methods specifically for Celestine::Svg
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
        drawable.draw(inner_elements)
        drawable
      end
    end
  end

  # Group class which can group multiple drawables together.
  class ::Celestine::Svg
    include Celestine::Meta::Context::Methods
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

  # Class which acts like a group, but applies masking to another drawable.
  class ::Celestine::Pattern
    include Celestine::Meta::Context::Methods
  end
end
