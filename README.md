# Celestine ![Crystal CI](https://github.com/redcodefinal/celestine/workflows/Crystal%20CI/badge.svg)


![Crystal CI](https://github.com/redcodefinal/celestine/blob/master/logo/logo.svg)

A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yml
dependencies:
  celestine:
    github: redcodefinal/celestine
```

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
 * [animateTransform](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/animateTransform) as animate_transform
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

HMU via issues

## Contributing

1. Fork it (<https://github.com/redcodefinal/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ian Rash](https://github.com/redcodefinal) - creator and maintainer
