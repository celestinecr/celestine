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
require "./drawables/line"
require "./drawables/polygon"
require "./drawables/polyline"

require "./effects/animation/animate"
require "./effects/animation/animate_motion"
require "./effects/animation/transform/*"

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
  CLASSES = [
    Celestine::Svg, Celestine::Circle, Celestine::Rectangle, Celestine::Path,
    Celestine::Ellipse, Celestine::Group, Celestine::Image, Celestine::Text,
    Celestine::Anchor, Celestine::Line, Celestine::Polygon, Celestine::Polyline
  ]

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
          def mask(&block : Celestine::Mask ->)
            mask = Celestine::Mask.new
            yield mask
            define(mask)
            mask
          end

          # Create a marker object and add it to this `Celestine::Svg`'s defs
          def marker(&block : Celestine::Marker ->)
            marker = Celestine::Marker.new
            yield marker
            define(marker)
            marker
          end

          # Create a filter object and add it to this `Celestine::Svg`'s defs
          def filter(&block : Celestine::Filter ->)
            filter = Celestine::Filter.new
            yield filter
            define(filter)
            filter
          end

          # Create a pattern object and add it to this `Celestine::Svg`'s defs
          def pattern(&block : Celestine::Pattern ->)
            pattern = Celestine::Pattern.new
            yield pattern
            define(pattern)
            pattern
          end

          # Create a linear gradient object and add it to this `Celestine::Svg`'s defs
          def linear_gradient(&block : Celestine::Gradient::Linear ->)
            linear = Celestine::Gradient::Linear.new
            yield linear
            define(linear)
            linear
          end

          # Create a radial gradient object and add it to this `Celestine::Svg`'s defs
          def radial_gradient(&block : Celestine::Gradient::Radial ->)
            radial = Celestine::Gradient::Radial.new
            yield radial
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
        def {{ klass.stringify.split("::").last.downcase.id }}(define = false, &block : {{klass.id}} ->) : {{klass.id}}
          element = {{klass.id}}.new
          yield element
          if define
            define(element)
          else
            self << element
          end
          element
        end
      end

      # Makes context methods for classes without a defs collection.
      private macro make_non_context_method(klass)
        # Allows a `{{klass.id}}` to be made using a DSL call, and added to this drawables items.
        def {{ klass.stringify.split("::").last.downcase.id }}(&block : {{klass.id}} ->) : {{klass.id}}
          element = {{klass.id}}.new
          yield element
          self << element
          element
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
      def use(&block : Celestine::Use ->)
        use_elem = Celestine::Use.new
        yield use_elem
        self << use_elem
        use_elem
      end

      # Reuses an element defined using `define: true` and then opens a block with that object for configuring
      def use(drawable : Celestine::Drawable, &block : Celestine::Use ->)
        use_elem = Celestine::Use.new
        if drawable.id
          use_elem.target_id = drawable.id.to_s
          yield use_elem
          self << use_elem
          use_elem
        else
          raise "Reused objects must have an id assigned"
        end
      end

      # Reuses an element defined using `define: true` by id and then opens a block with that object for configuring
      def use(id : String, &block : Celestine::Use ->)
        use_elem = Celestine::Use.new
        use_elem.target_id = id
        yield use_elem
        self << use_elem
        use_elem
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

{% unless flag?(:release) %}
require "./docs"
{% end %}
