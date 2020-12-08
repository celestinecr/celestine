# Celestine ![Crystal CI](https://github.com/celestinecr/celestine/workflows/Crystal%20CI/badge.svg) [![Documentation badge](https://img.shields.io/badge/docs-latest-green.svg?style=flat-square)](https://docs.celestine.dev)


[![Celestine Logo](https://raw.githubusercontent.com/celestinecr/celestine/master/logo/logo.svg)](https://github.com/celestinecr/celestine/blob/master/src/make_logo.cr)


A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yml
dependencies:
  celestine:
    github: celestinecr/celestine
```

## Docs
Documentation is cool, you can view the docs for Celestine at:
 * [docs.celestine.dev](https://docs.celestine.dev)
 * [github.io](https://celestinecr.github.io/celestine)

## SVG Stuff It Can Do

A full list is [here](/dev_docs/svg_element_checklist.md).

 *TODO*
 * Full SVG support for all [elements](https://developer.mozilla.org/en-US/docs/Web/SVG/Element) and [attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)
 * Finish adding all filters
 * Add pattern
 * Add gradients


## Usage

First, all drawing is done through `Celestine.draw` this returns a string SVG element, or works on an `IO`. You can easily embed this into webpages for dynamic server side drawing of assets.

`Celestine.draw` takes a block which takes a `Celestine::Meta::Context` (or `ctx` in the examples), the basis of all DSL calls in Celestine.

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

All context methods such as `rectangle` or `circle` take a block that takes their respective types, and needs to have an object of that type returned.

A short list of the Celestine types that can be used by `Celestine::Meta::Context` and their DSL methods

 * [Celestine::Rectangle](https://docs.celestine.dev/Celestine/Rectangle.html) -> [rectangle](https://docs.celestine.dev/Celestine/Meta/Context.html#rectangle(define=false,&block:Celestine::Rectangle-%3ECelestine::Rectangle):Celestine::Rectangle-instance-method)
 * [Celestine::Circle](https://docs.celestine.dev/Celestine/Circle.html) -> [circle](https://docs.celestine.dev/Celestine/Meta/Context.html#circle(define=false,&block:Celestine::Circle-%3ECelestine::Circle):Celestine::Circle-instance-method)
 * [Celestine::Ellipse](https://docs.celestine.dev/Celestine/Ellipse.html) -> [ellipse](https://docs.celestine.dev/Celestine/Meta/Context.html#ellipse(define=false,&block:Celestine::Ellipse-%3ECelestine::Ellipse):Celestine::Ellipse-instance-method)
 * [Celestine::Path](https://docs.celestine.dev/Celestine/Path.html) -> [path](https://docs.celestine.dev/Celestine/Meta/Context.html#path(define=false,&block:Celestine::Path-%3ECelestine::Path):Celestine::Path-instance-method)
 * [Celestine::Marker](https://docs.celestine.dev/Celestine/Marker.html) -> [marker](https://docs.celestine.dev/Celestine/Meta/Context.html#marker(&block:Celestine::Marker-%3ECelestine::Marker)-instance-method)
 * [Celestine::Mask](https://docs.celestine.dev/Celestine/Mask.html) -> [mask](https://docs.celestine.dev/Celestine/Meta/Context.html#mask(&block:Celestine::Mask-%3ECelestine::Mask)-instance-method)
 * [Celestine::Text](https://docs.celestine.dev/Celestine/Text.html) -> [text](https://docs.celestine.dev/Celestine/Meta/Context.html#text(define=false,&block:Celestine::Text-%3ECelestine::Text):Celestine::Text-instance-method)
 * [Celestine::Group](https://docs.celestine.dev/Celestine/Group.html) -> [group](https://docs.celestine.dev/Celestine/Meta/Context.html#group(define=false,&block:Celestine::Group-%3ECelestine::Group):Celestine::Group-instance-method)
 * [Celestine::Image](https://docs.celestine.dev/Celestine/Image.html) -> [image](https://docs.celestine.dev/Celestine/Meta/Context.html#image(define=false,&block:Celestine::Image-%3ECelestine::Image):Celestine::Image-instance-method)
 * [Celestine::Use](https://docs.celestine.dev/Celestine/Use.html) -> [use](https://docs.celestine.dev/Celestine/Meta/Context/Methods.html#use(id:String)-instance-method)
 * [Celestine::Filter](https://docs.celestine.dev/Celestine/Filter.html) -> [filter](https://docs.celestine.dev/Celestine/Meta/Context.html#filter(&block:Celestine::Filter-%3ECelestine::Filter)-instance-method)

### Use
`Celestine::Use` can be used to save space in an SVG, and reuse certain elements without the need to copy the entire object into your SVG document.

The only caveat is that the `use` SVG element cannot change attributes it both doesn't own itself, or ones that have been set by it's ancestor, except in the case of `x`, `y`, `width`, and `height`. For example, the `use` element cannot change the `radius` of a `circle` even if the `radius` attribute had never been set.

`Celestine::Use` also requires that the drawable it is copying has an `id` set. If not `Celestine::Use` will still let you reference an ID that doesn't exist if you run `use` with a string `id`.

You can do this only with `Celestine::Meta::Context` (or `ctx` in the examples). `Celestine::Group`, `Celestine::Mask`, `Celestine::Marker` cannot define drawables.

```crystal
Celestine.draw do |ctx|
  # Only `Celestine::Meta::Context` is allowed to "define" objects.
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
Most drawables can use the `transform` method to translate, rotate, scale, and skew drawables.

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

### Animate
You can animate most simple SVG attributes using `animate` and the `from` and `to` attributes.
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

You can also animate more complicated attributes and transition using the `values` array. SVG attempts to interpolate these values when possible.

If you use `values` and don't also use the `key_times` array to designate the timing changes, it will evenly space the animation values in the alotted time.
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
You can animate movement along paths using `animateMotion`.

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
You can animate transform elements using `animateTransform`.

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
You can do some cool filtering using the `filter` DSL.

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
    end
    c
  end
end
```

#### Currently Implemented
 * [Celestine::Filter::Blend](https://docs.celestine.dev/Celestine/Filter/Blend.html) -> [blend](https://docs.celestine.dev/Celestine/Filter.html#blend(&block:Celestine::Filter::Blend-%3ECelestine::Filter::Blend)-instance-method)
 * [Celestine::Filter::Blur](https://docs.celestine.dev/Celestine/Filter/Blur.html) -> [blur](https://docs.celestine.dev/Celestine/Filter.html#blur(&block:Celestine::Filter::Blur-%3ECelestine::Filter::Blur)-instance-method)
 * [Celestine::Filter::ColorMatrix](https://docs.celestine.dev/Celestine/Filter/ColorMatrix.html) -> [color_matrix](https://docs.celestine.dev/Celestine/Filter.html#color_matrix(&block:Celestine::Filter::ColorMatrix-%3ECelestine::Filter::ColorMatrix)-instance-method)
 * [Celestine::Filter::ComponentTransfer](https://docs.celestine.dev/Celestine/Filter/ComponentTransfer.html) -> [component_transfer](https://docs.celestine.dev/Celestine/Filter.html#component_transfer(&block:Celestine::Filter::ComponentTransfer-%3ECelestine::Filter::ComponentTransfer)-instance-method)
 * [Celestine::Filter::Composite](https://docs.celestine.dev/Celestine/Filter/Composite.html) -> [composite](https://docs.celestine.dev/Celestine/Filter.html#composite(&block:Celestine::Filter::Composite-%3ECelestine::Filter::Composite)-instance-method)
 * [Celestine::Filter::DisplacementMap](https://docs.celestine.dev/Celestine/Filter/DisplacementMap.html) -> [displacement_map](https://docs.celestine.dev/Celestine/Filter.html#displacement_map(&block:Celestine::Filter::DisplacementMap-%3ECelestine::Filter::DisplacementMap)-instance-method)
 * [Celestine::Filter::Flood](https://docs.celestine.dev/Celestine/Filter/Flood.html) -> [flood](https://docs.celestine.dev/Celestine/Filter.html#flood(&block:Celestine::Filter::Flood-%3ECelestine::Filter::Flood)-instance-method)
* [Celestine::Filter::Image](https://docs.celestine.dev/Celestine/Filter/Image.html) -> [image](https://docs.celestine.dev/Celestine/Filter.html#image(&block:Celestine::Filter::Image-%3ECelestine::Filter::Image)-instance-method)
 * [Celestine::Filter::Merge](https://docs.celestine.dev/Celestine/Filter/Merge.html) -> [merge](https://docs.celestine.dev/Celestine/Filter.html#merge(&block:Celestine::Filter::Merge-%3ECelestine::Filter::Merge)-instance-method)
 * [Celestine::Filter::Morphology](https://docs.celestine.dev/Celestine/Filter/Morphology.html) -> [morphology](https://docs.celestine.dev/Celestine/Filter.html#morphology(&block:Celestine::Filter::Morphology-%3ECelestine::Filter::Morphology)-instance-method)
 * [Celestine::Filter::Offset](https://docs.celestine.dev/Celestine/Filter/Offset.html) -> [offset](https://docs.celestine.dev/Celestine/Filter.html#offset(&block:Celestine::Filter::Offset-%3ECelestine::Filter::Offset)-instance-method)
 * [Celestine::Filter::SpecularLighting](https://docs.celestine.dev/Celestine/Filter/SpecularLighting.html) -> [specular_lighting](https://docs.celestine.dev/Celestine/Filter.html#specular_lighting(&block:Celestine::Filter::SpecularLighting-%3ECelestine::Filter::SpecularLighting)-instance-method)
 * [Celestine::Filter::Tile](https://docs.celestine.dev/Celestine/Filter/Tile.html) -> [tile](https://docs.celestine.dev/Celestine/Filter.html#tile(&block:Celestine::Filter::Tile-%3ECelestine::Filter::Tile)-instance-method)
 * [Celestine::Filter::Turbulence](https://docs.celestine.dev/Celestine/Filter/Turbulence.html) -> [turbulence](https://docs.celestine.dev/Celestine/Filter.html#turbulence(&block:Celestine::Filter::Turbulence-%3ECelestine::Filter::Turbulence)-instance-method)

## Examples

If you'd like to see how the logo was made, check out [make_logo](https://github.com/redcodefinal/celestine/blob/master/src/make_logo.cr)

Here are some more intricate examples. [procedural_art](https://github.com/redcodefinal/procedural_art)

Real world examples made with Celestine. All of these are flat SVG files with no JS inside, using only functions built into Celestine.

 * [Inward](https://www.sol.vin/art/live/inward/)
 * [Mineshift](https://www.sol.vin/art/live/mineshift/)
 * [Hypnos1](https://cdpn.io/redcodefinal/fullpage/ZEOgzXX)
 * [Hypnos2](https://cdpn.io/redcodefinal/fullpage/WNxqYMy)
 * [Pschyoflower](https://codepen.io/redcodefinal/pen/mdrJeGZ)
 * [Semicircle Patchwork 1](https://codepen.io/redcodefinal/pen/WNGwdxe)
 * [Semicircle Patchwork 2](https://codepen.io/redcodefinal/pen/yLaOpae)
 * [Chromatic Aberration](https://codepen.io/redcodefinal/pen/zYKqpBZ)
 * [Polar Spins](https://codepen.io/redcodefinal/pen/RwGaxRY)

## Development

HMU via issues or make a pull request or something I don't know.

## Contributing

1. Fork it (<https://github.com/celestinecr/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request to the `development` branch at celestinecr/celestine

## Contributors

- [Ian Rash](https://github.com/redcodefinal) - creator and maintainer
