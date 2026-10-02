# Celestine

[![Celestine Logo](https://raw.githubusercontent.com/celestinecr/celestine/main/logo/logo.svg)](https://github.com/celestinecr/celestine/blob/main/src/make_logo.cr)


A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yaml
dependencies:
  celestine:
    github: celestinecr/celestine
```


## Usage

### Drawing

First, all drawing is done through [`Celestine.draw`][] this returns a string SVG element, or works on an `IO`. You can easily embed this into webpages for dynamic server side drawing of assets.

[`Celestine.draw`][] takes a block which takes a [`Celestine::Svg`][] (or `ctx` in the examples), the basis of all DSL calls in Celestine.

```crystal
Celestine.draw do |ctx|
end
```

You can create objects to be drawn with one of two methods.

```crystal
Celestine.draw do |ctx|
  # use this context's DSL methods
  ctx.rectangle do |r|
    r.x = 10
    r.y = 100
    r.fill = "black"
    r # You must return the drawable item at the end of the DSL method.
  end

  # Create the object and add it manually
  r = Celestine::Rectangle.new
  r.x = 10
  r.y = 100
  r.fill = "black"
  ctx << r
end
```

All context methods such as [`circle`][Celestine::Svg#circle] or [`rectangle`][Celestine::Svg#rectangle] take a block that takes their respective types, and needs to have an object of that type returned.

#### Currently Implemented

A short list of the Celestine types that can be used by [`Celestine::Svg`][] and their DSL methods

 * [`Celestine::Anchor`][] -> [`anchor`][Celestine::Svg#anchor]
 * [`Celestine::Circle`][] -> [`circle`][Celestine::Svg#circle]
 * [`Celestine::Ellipse`][] -> [`ellipse`][Celestine::Svg#ellipse]
 * [`Celestine::Filter`][] -> [`filter`][Celestine::Svg#filter]
 * [`Celestine::Group`][] -> [`group`][Celestine::Svg#group]
 * [`Celestine::Image`][] -> [`image`][Celestine::Svg#image]
 * [`Celestine::Marker`][] -> [`marker`][Celestine::Svg#marker]
 * [`Celestine::Mask`][] -> [`mask`][Celestine::Svg#mask]
 * [`Celestine::Path`][] -> [`path`][Celestine::Svg#path]
 * [`Celestine::Rectangle`][] -> [`rectangle`][Celestine::Svg#rectangle]
 * [`Celestine::Svg`][] -> [`svg`][Celestine::Svg#svg]
 * [`Celestine::Text`][] -> [`text`][Celestine::Svg#text]


### Nested SVG

[`Celestine::Svg`][] allows you to nest SVG.

```crystal
Celestine.draw do |ctx|
  ctx.svg do |svg_doc2|
    svg_doc2.rectangle do |r|
      r
    end

    svg_doc2.circle do |c|
      c
    end

    svg_doc2
  end
end
```

### Groups

[`Celestine::Group`][] allows you to group multiple elements under one parent. You can manipulate the `x`, `y`, and other attributes to apply them to the whole group, or just use it to combine elements easier.

```crystal
Celestine.draw do |ctx|
  ctx.group do |g|
    g.rectangle do |r|
      r
    end

    g.circle do |c|
      c
    end

    g
  end
end
```

Groups cannot [`define`][Celestine::Svg#define] objects like [`Celestine::Svg`][] can. Groups also cannot use the [`mask`][Celestine::Svg#mask], [`filter`][Celestine::Svg#filter], or [`marker`][Celestine::Svg#marker] DSL methods as they [`define`][Celestine::Svg#define] in the SVG document.

### Use
[`Celestine::Use`][] can be used to save space in an SVG, and reuse certain elements without the need to copy the entire object into your SVG document.

The only caveat is that the `use` SVG element cannot change attributes it both doesn't own itself, or ones that have been set by it's ancestor, except in the case of `x`, `y`, `width`, and `height`. For example, the `use` element cannot change the `radius` of a `circle` even if the `radius` attribute had never been set.

[`Celestine::Use`][] also requires that the drawable it is copying has an `id` set. If not [`Celestine::Use`][] will still let you reference an ID that doesn't exist if you run `use` with a string `id`.

You can do this only with [`Celestine::Svg`][] (or `ctx` in the examples). [`Celestine::Group`][], [`Celestine::Mask`][], [`Celestine::Marker`][] cannot define drawables. The `use` element will only copy elements in the current SVG document you are in, so if you nest SVG inside SVG you need to be wary of how you define objects.

```crystal
Celestine.draw do |ctx|
  # Only `Celestine::Svg` is allowed to "define" objects.
  ctx.rectangle(define: true) do |r|
    # Set r's x, y, width, height and other attributes here
    r.id = "our-rect" # YOU MUST SET AN ID TO BE ABLE TO REUSE A COMPONENT, OR THERE IS NO WAY TO REFERENCE IT.
    r
  end

  ctx.use do |use|
    use.x = 100
    use.y = 3000
    use.width = 99
    use.height = 99    
    use.fill = "black"

    # Cannot use this because `Celestine::Use` cannot change attributes specific to a drawable
    # only the attributes its shares with the type it's using.
    # use.radius_x = 1000

    use
  end
end
```

### Transform
Most drawables can use the [`transform`][Celestine::Modules::Transform#transform] method to translate, rotate, scale, and skew drawables.

```crystal
Celestine.draw do |ctx|
  ctx.rectangle do |r|
    # Set r's x, y, width, height and other attributes here
    r.transform do |t|
      t.rotate(60, 0, 0) # Rotate by 60 degrees, at origin 0, 0
      t.translate(50, 60) # Move by 50, 60
      t.scale(100, 100) # Scale up 100x
      t.skew_x(10)
      t.skew_y(10)
      t.matrix(1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
      t
    end
    r
  end
end
```

### Masking
You can use masks to make complicated shapes.

```crystal
Celestine.draw do |ctx|
  our_mask = ctx.mask do |mask|
    mask.id = "our-mask" # YOU MUST SET A UNIQUE ID FOR THE MASK!
    mask.rectangle do |r| # Works just like a group
      # Set r's x, y, width, height and other attributes here
      r.fill = "black" # Will make everything under it invisibile and transparent
      r.fill = "white" # Will make everything under it visible
      r
    end
    mask
  end

  ctx.circle do |c|
    # Set c's x, y, radius and other attributes here
    c.set_mask our_mask # Set with the mask object directly
    c.set_mask "our-mask" # Set via string id
    c
  end
end
```

### Patterns
You can apply complciated tiling/repeating fills and strokes using the [`pattern`][Celestine::Svg#pattern] DSL.

```crystal
Celestine.draw do |ctx|
  our_pattern = ctx.pattern do |pattern|
    pattern.id = "our-pattern" # ALWAYS SET ID FOR A PATTERN OR IT CAN'T BE USED!
    pattern.rectangle do |r|
      r
    end
    pattern
  end

  ctx.circle do |c|
    # Either
    c.set_fill(our_pattern)
    # or
    c.set_stroke(our_pattern)
    c
  end
end
```

### Gradients
You can apply gradient fills and strokes using the [`linear_gradient`][Celestine::Svg#linear_gradient] and [`radial_gradient`][Celestine::Svg#radial_gradient] DSLs

```crystal
Celestine.draw do |ctx|
  our_gradient = ctx.linear_gradient do |gradient|
    gradient.id = "our-gradient" # ALWAYS SET ID FOR A GRADIENT OR IT CAN'T BE USED!
    gradient.stop do |stop|
      stop.offset = 10
      stop.offset_units = "%"
      stop.color = "red"
      stop.opacity = 1.0
      stop
    end
    gradient
  end

  ctx.circle do |c|
    # Either
    c.set_fill(our_gradient)
    # or
    c.set_stroke(our_gradient)
    c
  end
end
```

### Animate
You can animate most simple SVG attributes using [`animate`][Celestine::Modules::Animate#animate] and the `from` and `to` attributes.
```crystal
Celestine.draw do |ctx|
  ctx.circle do |c|
    # IF ANIMATING AN ATTRIBUTE DO NOT SET IT IN ANY WAY, IT WILL OVERRIDE THE ANIMATION, BLAME SVG NOT ME
    # EX:
    #     Using `c.radius = 100` will ruin the animation.
    c.animate do |a|
      a.attribute = "r" # Choose it directly
      a.attribute = Celestine::Circle::Attrs::RADIUS # Choose it using the predefined constants
      a.from = 100
      a.to = 200
      a.duration = 10
      a.repeat_count = "indefinite"
      a
    end
    c
  end
end
```

You can also animate more complicated attributes and transition using the [`values`][Celestine::Modules::CommonAnimate#values] array. SVG attempts to interpolate these values when possible.

If you use [`values`][Celestine::Modules::CommonAnimate#values] and don't also use the [`key_times`][Celestine::Modules::CommonAnimate#key_times] array to designate the timing changes, it will evenly space the animation values in the alotted time.
```crystal
Celestine.draw do |ctx|
  ctx.circle do |c|
    c.animate do |a|
      a.attribute = Celestine::Circle::Attrs::Fill
      a.values << "red" # Will start the color of the fill at red
      a.values << "blue" # Then interpolate to blue
      a.values << "red" # Then interpolate back to red.
      a.duration = 10
      a.repeat_count = "indefinite"
      a
    end

    c.animate do |a|
      a.attribute = Celestine::Circle::Attrs::Stroke
      a.values << "red" # Will start the color of the fill at red
      a.values << "blue" # Then interpolate to blue
      a.values << "red" # Then interpolate back to red.

      a.key_times << 0.0  # Change to red to start. You should almost always use 0.0 as your first key_times value
      a.key_times << 0.25 # Interpolate to blue at 25% of the duration
      a.key_times << 0.75 # Interpolate to red at 75% of the duration
      a_key_times << 1.0  # End the animation

      a.duration = 10
      a.repeat_count = "indefinite"
      a
    end
    c
  end
end
```

### AnimateMotion
You can animate movement along paths using [`animate_motion`][Celestine::Modules::Animate::Motion#animate_motion].

```crystal
Celestine.draw do |ctx|
  ctx.circle do |c|
    c.animate_motion do |a|
      # Make the path the animateMotion element will follow.
      a.mpath do |path|
        path.a_move(200, 200)
        path.r_line(20, 20)
        path.r_line(-20, 20)
        path.r_line(-20, -20)
        path.r_line(20, -20)
        path
      end
      a.duration = 10
      a.repeat_count = "indefinite"
      a
    end
    c
  end
end
```

### AnimateTransform
You can animate transform elements using [`animate_transform_*`][Celestine::Modules::Animate::Transform].

Only rotate is supported right now.
```crystal
Celestine.draw do |ctx|
  ctx.circle do |c|
    c.animate_transform_rotate do |a|
      a.use_from = true # Need to set these to allow `from` to render in the SVG element
      a.use_to = true   # Need to set these to allow `to` to render in the SVG element
      a.from_angle = 0
      a.to_angle = 360
      a.from_origin_x = a.from_origin_y = a.to_origin_x = a.to_origin_y = 0
      a.duration = 10
      a.repeat_count = "indefinite"
      a
    end
    c
  end
end
```

### Filters
You can do some cool filtering using the [`filter`][Celestine::Svg#filter] DSL.

```crystal
Celestine.draw do |ctx|
  our_filter = ctx.filter do |f|
    f.id = "our-filter" # ALWAYS SET ID FOR A FILTER OR IT CAN'T BE USED!
    f.blur do |b|
      b.standard_deviation = 5
      b
    end
    f
  end

  ctx.circle do |c|
    # Either
    c.set_filter("our-filter")
    # or
    c.set_filter(our_filter)
    c
  end
end
```

#### Currently Implemented
 * [`Celestine::Filter::Blend`][] -> [`blend`][Celestine::Filter#blend]
 * [`Celestine::Filter::Blur`][] -> [`blur`][Celestine::Filter#blur]
 * [`Celestine::Filter::ColorMatrix`][] -> [`color_matrix`][Celestine::Filter#color_matrix]
 * [`Celestine::Filter::ComponentTransfer`][] -> [`component_transfer`][Celestine::Filter#component_transfer]
 * [`Celestine::Filter::Composite`][] -> [`composite`][Celestine::Filter#composite]
 * [`Celestine::Filter::DisplacementMap`][] -> [`displacement_map`][Celestine::Filter#displacement_map]
 * [`Celestine::Filter::DropShadow`][] -> [`drop_shadow`][Celestine::Filter#drop_shadow]
 * [`Celestine::Filter::Flood`][] -> [`flood`][Celestine::Filter#flood]
 * [`Celestine::Filter::Image`][] -> [`image`][Celestine::Filter#image]
 * [`Celestine::Filter::Merge`][] -> [`merge`][Celestine::Filter#merge]
 * [`Celestine::Filter::Morphology`][] -> [`morphology`][Celestine::Filter#morphology]
 * [`Celestine::Filter::Offset`][] -> [`offset`][Celestine::Filter#offset]
 * [`Celestine::Filter::SpecularLighting`][] -> [`specular_lighting`][Celestine::Filter#specular_lighting]
 * [`Celestine::Filter::Tile`][] -> [`tile`][Celestine::Filter#tile]
 * [`Celestine::Filter::Turbulence`][] -> [`turbulence`][Celestine::Filter#turbulence]
