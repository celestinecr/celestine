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

    # Want to specify in css units? Try these handy patch methods
    circle.radius = 10.px
    circle.x = 10.percent
    circle.y = 10.vmax
    circle
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
      t
    end

    # Animate elements
    rect.animate do |anim|
      anim.duration = 10.s
      # Select attribute names with these constants
      anim.attribute = Celestine::Rectangle::Attrs::RADIUS_X
      anim.values << 0
      anim.values << 10
      anim.values << 0
      anim
    end

    rect.animate_motion do |anim|
      anim.duration = 10.s
      anim.mpath do |path|
        path.a_move 0,0
        path.r_line 10,0
        path.r_line 10,10
        path.close
        path
      end
    end
    
    rect
  end

  # Add things to defs to use them later or multiple times
  our_group = ctx.group(define: true) do |x|
    group.id = "our-group"

    # We use the groups context methods
    group.circle do |circle|
      circle.x = 10
      circle.y = 20
      circle.radius = 20
      circle.fill = "red"
      circle
    end

    group.circle do |circle|
      circle.x = 10
      circle.y = 20
      circle.radius = 10
      circle.fill = "blue"
      circle
    end
    group
  end

  # We can then use the item multiple times
  ctx.use(our_group) # Draw in the predetermined location
  ctx.use("our_group") # Draw in the predetermined location
  ctx.use(our_group) # Draw in the predetermined location
  
  ctx.use(our_group) do |use|
    use.x = 20
    use.y = 20

    # Can use transform on whole groups
    use.transform {|t| t.rotate(10, 0, 0)}
    use
  end
end
```

## Development

HMU via issues

## Contributing

1. Fork it (<https://github.com/your-github-user/celestine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ian Rash](https://github.com/your-github-user) - creator and maintainer
