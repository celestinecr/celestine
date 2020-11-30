# Celestine ![Crystal CI](https://github.com/redcodefinal/celestine/workflows/Crystal%20CI/badge.svg) [![Documentation badge](https://img.shields.io/badge/docs-latest-green.svg?style=flat-square)](https://redcodefinal.github.io/celestine/)


![Celestine Logo](https://github.com/redcodefinal/celestine/blob/master/logo/logo.svg)

A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yml
dependencies:
  celestine:
    github: redcodefinal/celestine
```

## Docs
Documentation is cool, you can view the docs for Celestine at:
 * [docs.celestine.dev](https://docs.celestine.dev)
 * [github.io](https://redcodefinal.github.io)

## SVG Stuff It Can Do

 * [circle](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/circle)
 * [rect](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/rect) as rectangle
 * [g](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/g) as group
 * [ellipse](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/ellipse)
 * [text](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/text)
 * [image](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/image)
 * [path](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path)
 * [use](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/use)
 * [mask](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/mask)
 * [animate](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/animate)
 * [animateTransform](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/animateTransform) as animate_transform_rotate 
 * [animateMotion](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/animateMotion) as animate_motion
 * [mpath](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/mpath) via animate_motion

 *TODO*
 * Filters :( gonna need to design a whole system just for those
 * Full SVG support for all [elements](https://developer.mozilla.org/en-US/docs/Web/SVG/Element) and [attributes](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute)



## Usage

First, all drawing is done through `Celestine.draw` this returns a string SVG element, or works on an `IO`. You can easily embed this into webpages for dynamic server side drawing of assets.

`Celestine.draw` takes a block which takes a `Celestine::Meta::Context`, the basis of all DSL calls in Celestine.

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

A list of the Celestine types and their DSL methods

 * Celestine::Rectangle -> rectangle
 * Celestine::Circle -> circle
 * Celestine::Ellipse -> ellipse
 * Celestine::Path -> path
 * Celestine::Mask -> mask
 * Celestine::Text -> text
 * Celestine::Group -> group
 * Celestine::Image -> image
 * Celestine::Use -> use


### Transform
Most drawables can use the `transform` method to move, rotate, scale, and skew drawables.

```crystal
Celestine.draw do |ctx|
  ctx.rectangle do |r|
    # Set r's x, y, width, height and other attributes here
    r.transform do |t|
      t.rotate(60, 0, 0) # Rotate by 60 degrees, at origin 0, 0
      t.translate(50, 60) # Move by 50, 60
      t.scale(100, 100) # Scale up 100x
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
You can animate some simpler SVG attributes using `animate`.
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
    f.id = "our-filter" # ALWAYS SET ID FOR A FILTER!
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
 * Celestine::Filter::Blend -> blend
 * Celestine::Filter::Blur -> blur
 * Celestine::Filter::ColorMatrix -> color_matrix
 * Celestine::Filter::ComponentTransfer -> component_transfer
 * Celestine::Filter::Composite -> composite
 * Celestine::Filter::DisplacementMap -> displacement_map
 * Celestine::Filter::Flood -> flood
 * Celestine::Filter::Merge -> merge
 * Celestine::Filter::Morphology -> morphology
 * Celestine::Filter::Offset -> offset
 * Celestine::Filter::SpecularLighting -> specular_lighting
 * Celestine::Filter::Tile -> specular_lighting
 * Celestine::Filter::Turbulence -> turbulence


Here's a quick and dirty intro to features.
[crash_course](https://github.com/redcodefinal/celestine/blob/master/src/crash_course.cr)

Here are some more intricate examples.
[procedural_art](https://github.com/redcodefinal/procedural_art)

Real world examples made with Celestine. All of these are flat SVG files with no JS inside, using only functions built into Celestine.

 * [Inward](https://www.sol.vin/art/live/inward/)
 * [Mineshift](https://www.sol.vin/art/live/mineshift/)
 * [Hypnos1](https://cdpn.io/redcodefinal/fullpage/ZEOgzXX)
 * [Hypnos2](https://cdpn.io/redcodefinal/fullpage/WNxqYMy)

## Development

HMU via issues or make a pull request or something I don't know.

## Contributing

1. Fork it (<https://github.com/redcodefinal/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ian Rash](https://github.com/redcodefinal) - creator and maintainer
