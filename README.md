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

## Usage

Here's a quick and dirty intro to features.

First, all drawing is done through `Celestine.draw` this returns a string SVG element. You can easily embed this into webpages for dynamic server side drawing of assets.

```crystal
require "celestine"

File.open("./bin/test.svg", "w+") do |f|
  f.puts(Celestine.draw do |ctx|
    # ctx.height = 100
    # ctx.width = 100
    ctx.view_box = {x: 0, y: 0, w: 100, h:100}

    # Make BG rectangle and render it directly to svg
    ctx.rectangle do |bg|
      # Modify the rectangle.
      bg.x = 0
      bg.y = 0
      bg.width = 100
      bg.height = 100
      bg.fill = "gray"

      #always return the object at the end of a block.
      bg
    end

    # Make a group of objects, and instead of rendering it to screen, save it to a place we can render later.
    square_group = ctx.group(define: true) do |group|
      # if using `define: true` you must include an ID, or it won't work.
      group.id = "square-group"
      padding = 15.0
      size = (100-(padding*5))/5.0
      5.times do |x|
        5.times do |y|
          # Draw a rectangle
          group.rectangle do |rect|
            # Modify the rectangle here
            rect.x = (padding/2.0) + (x * size) + (x * padding)
            rect.y = (padding/2.0) + (y * size) + (y * padding)
            rect.width = size
            rect.height = size
            
            # You can use CSS color names
            rect.fill = "black"
            # Or hex colors
            rect.fill = "#000000"

            rect.stroke = "red"

            #Want to specify css units? You can with these patches
            rect.stroke_width = 1.px # em, rem, vmax, vh, vw, etc
            # Pass it back when you are done. (it's a struct)
            rect
          end
        end
      end
      group
    end

    # Now we can reuse a defined element a couple of different ways

    # First we can use the objects variable
    ctx.use(square_group)
    # We can also use the group's ID
    ctx.use("square-group")
    
    # you can also configure the reused element
    ctx.use(square_group) do |g|

      # Can't change stroke and fill of a reused group unfortunately but you can change it in the group directly and then re add that group
      g.stroke = "blue" # Doesn't work

      # Motion as well
      g.animate_motion do |anim|
        anim.duration = 5.s
        anim.repeat_count = "indefinite"
        anim.mpath do |path|
          path.a_move 0, 0 
          path.r_line 2.5, 0
          path.r_line 0, 2.5
          path.r_line -2.5, 0
          path.close
          path
        end
        anim
      end
      g
    end

    # Paths are supported through DSL calls
    ctx.path do |path|
      # a stands for absolute, r stands for relative
      path.a_move 10, 30
      path.a_arc x: 50, y: 30, rx: 20, ry: 20, rotation: 0, large: false, flip: true
      path.a_arc  x: 90, y: 30, rx: 20, ry: 20, rotation: 0, large: false, flip: true
      path.a_q_bcurve 90, 60, 50, 90
      path.a_q_bcurve 10, 60, 10, 30
      path.close

      path.stroke_width = 1.px
      path.fill_opacity = 0
      path.stroke_opacity = 0.9
      
      # Animate element attributes
      path.animate do |anim|
        anim.duration = 2.s
        anim.repeat_count = "indefinite"
        # Select attribute names with these constants
        anim.attribute = "stroke"
        anim.values << "pink"
        anim.values << "red"
        anim.values << "pink"
        anim
      end

      path.animate do |anim|
        anim.duration = 3.s
        anim.repeat_count = "indefinite"
        # Select attribute names with these constants
        anim.attribute = "stroke-width"
        anim.values << 0.5
        anim.values << 5
        anim.values << 0.5
        anim
      end

      path.animate do |anim|
        anim.duration = 4.s
        anim.repeat_count = "indefinite"
        # Select attribute names with these constants
        anim.attribute = "stroke-opacity"
        anim.values << 0.5
        anim.values << 1
        anim.values << 0.5
        anim
      end
      path
    end
  end)
end
```

Real world examples made with Celestine

https://www.sol.vin/art/live/inward/
https://www.sol.vin/art/live/mineshift/



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
