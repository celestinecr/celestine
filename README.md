# Celestine

A neat library and DSL for creating graphics using SVG

## Installation

Add to shards.yml

```yml
dependencies:
  celestine:
    github: redcodefinal/celestine
```

## Usage

Here's a quick and dirty intro to features.

First, all drawing is done through `Celestine.draw`

```crystal
require "celestine"

Celestine.draw do |ctx|
  ctx.view_box = {x: 0, y: 0, w: 100, h:100}
  # draw a circle
  ctx.circle do |circle|
    # We are now configuring the circle
    circle.x = 10
    circle.y = 20
    circle.stroke = "black"
    circle.fill = "none"
    circle.radius = 10

    # Want to specify in css units? Try these fun patch methods
    circle.radius = 10.px
    circle.x = 10.percent
    circle.y = 10.vmax
  end

  # draw a rectangle
  ctx.rectangle do |rect|
    rect.x = 50.px
    rect.y = 50.px

    rect.width = 100.px
    rect.height = 100.px

    # Use transform methods
    rect.transform do |t|
      # transfrom by matrix
      t.matrix(0, 0, 1, 1, 1, 0)
      # translate the position
      t.translate(10, 10)
      # rotate it by an origin point (absolute)
      t.rotate(40, 0, 0)
    end

    # Animate elements
  end
end
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ian Rash](https://github.com/your-github-user) - creator and maintainer
