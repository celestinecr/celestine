module Celestine::Test::Mineshift::Complex
  class_property seed : Int32 = 0

  def self.make_img_path(seed)
    "/test/mineshift/#{seed}.svg"
  end

  def self.make_new_img
    @@seed &+= 1
    File.open("./bin" + make_img_path(@@seed), "w+") { |f| f.puts self.make }
  end

  COLORS = [
    {bg: "#e2f1af", levels: ["#e3d888", "#84714f", "#5a3a31", "#31231e"]},
    {bg: "#ddf3b5", levels: ["#83c923", "#74a31d", "#577a15", "#39510e"]},
    {bg: "#ecfee8", levels: ["#c2efeb", "#6ea4bf", "#41337a", "#331e36"]},
    {bg: "#f0f3bd", levels: ["#02c39a", "#00a896", "#028090", "#06668d"]},
    {bg: "#ffcdB2", levels: ["#ffb4a2", "#e5989b", "#b5838d", "#6d6875"]},
    {bg: "#6fffe9", levels: ["#5bc0be", "#3a506b", "#1c2541", "#0b132b"]},
    {bg: "#d8dbe2", levels: ["#a9bcd0", "#58a4b0", "#373f51", "#1b1b1e"]},
    {bg: "#f6aa1c", levels: ["#bc3908", "#941b0c", "#621708", "#220901"]},
    {bg: "#e0fbfc", levels: ["#c2dfe3", "#9db4c0", "#5c6b73", "#253237"]},
    {bg: "#9742a1", levels: ["#7c3085", "#611f69", "#4a154b", "#340f34"]},
    {bg: "#c4fff9", levels: ["#9ceaef", "#68d8d6", "#3dccc7", "#07beb8"]},
    {bg: "#ffffff", levels: ["#5bc0be", "#3a506b", "#1c2541", "#0b132b"]},
    {bg: "#ff9b54", levels: ["#ff7f51", "#ce4257", "#720026", "#4f000b"]},
    {bg: "#edeec9", levels: ["#dde7c7", "#bfd8bd", "#98c9a3", "#77bfa3"]},
    {bg: "#b8f3ff", levels: ["#8ac6d0", "#63768d", "#554971", "#36213e"]},
    {bg: "#f0ebd8", levels: ["#748cab", "#3e5c76", "#1d2d44", "#0d1321"]},
    {bg: "#f9dbbd", levels: ["#ffa5ab", "#da627d", "#a53860", "#450920"]},
    {bg: "#e09f7d", levels: ["#ef5d60", "#ec4067", "#a01a7d", "#311847"]},
    {bg: "#53b3cb", levels: ["#f9c22e", "#f15946", "#e01a4f", "#0c090d"]},
    {bg: "#fefcfb", levels: ["#1282a2", "#034078", "#001f54", "#0a1128"]},
    {bg: "#e0d68a", levels: ["#cb9173", "#8e443d", "#511730", "#320a28"]},
    {bg: "#f3c677", levels: ["#f9564f", "#b33f62", "#7b1e7a", "#0c0a3e"]},
    {bg: "#efd9ce", levels: ["#dec0f1", "#b79ced", "#957fef", "#7161ef"]},
    {bg: "#f0f465", levels: ["#9cec5b", "#50c5b7", "#6184db", "#533a71"]},
    {bg: "#ad2831", levels: ["#800e13", "#640d14", "#38040e", "#250902"]},
  ]

  HEIGHT       = 1000
  WIDTH        =  800
  FRAME_COPIES =    2
  FRAME_HEIGHT = HEIGHT * FRAME_COPIES
  MAX_LEVELS   = 4

  BLOCK_SPACING_SEED         = 0.283673_f32
  CENTER_MASK_DEVIATION_SEED = 0.834728_f32
  WINDOW_SCALE_SEED          =      2.3_f32
  WINDOW_ASSET_SEED          =     1.63_f32

  LVL_SIZES = {
    0 => 0.02,
    1 => 0.04,
    2 => 0.06,
    3 => 0.08,
  }

  # Data for the size of levels
  LEVEL_DATA = {
    0 => {
      max_distance: ((WIDTH/2)*LVL_SIZES[0]).to_i * 10,
      max_blocks:   4,
      block_size:   ((WIDTH/2)*LVL_SIZES[0]).to_i,
      deviation:    4,
    },

    1 => {
      max_distance: ((WIDTH/2)*LVL_SIZES[1]).to_i * 12,
      max_blocks:   3,
      block_size:   ((WIDTH/2)*LVL_SIZES[1]).to_i,
      deviation:    2,
    },

    2 => {
      max_distance: ((WIDTH/2)*LVL_SIZES[2]).to_i * 16,
      max_blocks:   3,
      block_size:   ((WIDTH/2)*LVL_SIZES[2]).to_i,
      deviation:    3,
    },

    3 => {
      max_distance: ((WIDTH/2)*LVL_SIZES[3]).to_i * 20,
      max_blocks:   7,
      block_size:   ((WIDTH/2)*LVL_SIZES[3]).to_i,
      deviation:    2,
    },
  }

  @@perlin = PerlinNoise.new(0)
  @@windows = [] of Array(Celestine::Group)

  def self.window_assets
    @@windows
  end

  # Makes statically generated window assets
  def self.make_window_assets(ctx : Celestine::Meta::Context)
    @@windows.clear
    # Creates a list of all windows we want to make.
    MAX_LEVELS.times do |level|
      @@windows << [] of Celestine::Group
      window_padding = LEVEL_DATA[level][:block_size] * 0.3
      window_size = LEVEL_DATA[level][:block_size] - (window_padding * 2)

      # Simple square window
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.rectangle do |window|
          window.id = "basic-square-window-#{level}"
          window.x = window_padding
          window.y = window_padding
          window.width = window_size
          window.height = window_size
          window.fill = "black"
          window
        end
        group
      end

      # Square with a y bar
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("basic-square-window-#{level}")

        group.rectangle do |window|
          window.id = "window-square-bar-y-#{level}"
          window.width = window_size/4
          window.height = window_size + 2 # offset one to avoid masking lines

          window.x = window_padding + (window_size/2) - (window.width.to_i/2)
          window.y = window_padding - 2 # offset plus one to avoid masking lines

          window.fill = "white"
          window
        end
        group
      end

      # Square with an x bar
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("basic-square-window-#{level}")

        group.rectangle do |window|
          window.id = "window-square-bar-x-#{level}"
          window.height = window_size/4
          window.width = window_size + 2 # offset one to avoid masking lines

          window.y = window_padding + (window_size/2) - (window.height.to_i/2)
          window.x = window_padding - 2 # offset plus one to avoid masking lines

          window.fill = "white"
          window
        end
        group
      end

      # Square with an x and y bar
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("basic-square-window-#{level}")
        group.use("window-square-bar-x-#{level}")
        group.use("window-square-bar-y-#{level}")
        group
      end

      # Square with square inside
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("basic-square-window-#{level}")

        group.rectangle do |window|
          window.height = window_size/2
          window.width = window_size/2 # offset one to avoid masking lines

          window.y = LEVEL_DATA[level][:block_size]/2 - (window.height.to_i/2)
          window.x = LEVEL_DATA[level][:block_size]/2 - (window.width.to_i/2)

          window.fill = "white"
          window
        end

        group
      end

      # Simple circle
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.circle do |window|
          window.id = "window-circle-#{level}"
          window.x = LEVEL_DATA[level][:block_size]/2
          window.y = LEVEL_DATA[level][:block_size]/2
          window.radius = LEVEL_DATA[level][:block_size]/2 * 0.4
          window.fill = "black"
          window
        end
        group
      end

      # Simple circle with a circle inside
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("window-circle-#{level}")

        group.circle do |window|
          window.id = "window-circle-inner-#{level}"
          window.x = LEVEL_DATA[level][:block_size]/2
          window.y = LEVEL_DATA[level][:block_size]/2
          window.radius = LEVEL_DATA[level][:block_size]/2 * 0.2
          window.fill = "white"
          window
        end
        group
      end

      # Diamond
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.path do |path|
          path.id = "window-diamond-#{level}"
          full_block = LEVEL_DATA[level][:block_size]
          half_block = LEVEL_DATA[level][:block_size]/2
          path.a_move(half_block, window_padding)
          path.a_line(full_block - window_padding, half_block)
          path.a_line(half_block, full_block - window_padding)
          path.a_line(window_padding, half_block)
          path.close
          path.fill = "black"
          path
        end
        group
      end

      # Diamond with a diamond inside
      @@windows[level] << ctx.group(define: true) do |group|
        group.id = "window-#{level}-#{@@windows[level].size}"
        group.use("window-diamond-#{level}")

        group.path do |path|
          path.id = "window-diamond-inner-#{level}"
          full_block = LEVEL_DATA[level][:block_size]
          half_block = LEVEL_DATA[level][:block_size]/2
          quarter_block = LEVEL_DATA[level][:block_size]/4

          path.a_move(half_block, quarter_block + (window_padding/2))
          path.a_line(full_block - quarter_block - (window_padding/2), half_block)
          path.a_line(half_block, full_block - quarter_block - (window_padding/2))
          path.a_line(quarter_block + (window_padding/2), half_block)
          path.close
          path.fill = "white"
          path
        end
        group
      end
    end
  end

  def self.make_center_mask_rectangles(level : Int32)
    mask_rectangles = [] of Celestine::Rectangle

    center = (WIDTH/2).to_i
    current_height = 0
    # Perlin counter (provides random values by increasing seed)
    p_counter = 1

    # Creates the middle mask rectangles
    until current_height > FRAME_HEIGHT
      mask_rect = Celestine::Rectangle.new
      mask_rect.id = "mask-rect-#{level}-#{p_counter}"

      additional_block_spacing = @@perlin.prng_int(p_counter, current_height, level + 1, 0, LEVEL_DATA[level][:max_blocks], BLOCK_SPACING_SEED) * LEVEL_DATA[level][:block_size]
      mask_rect.width = LEVEL_DATA[level][:max_distance] - additional_block_spacing
      mask_rect.height = LEVEL_DATA[level][:block_size] + 1 # Offset by one because of svg antialiasing issues

      position_x = center - (mask_rect.width.to_i/2).to_i
      deviation = (@@perlin.int(current_height, p_counter, level + 1, -LEVEL_DATA[level][:deviation], LEVEL_DATA[level][:deviation], CENTER_MASK_DEVIATION_SEED) * LEVEL_DATA[level][:block_size])
      mask_rect.y = current_height - 1 # Offset by one to ensure lines don't draw (svg antialiasing)
      mask_rect.x = position_x - deviation
      mask_rect.fill = "black"
      current_height += LEVEL_DATA[level][:block_size]
      p_counter += 1

      mask_rectangles << mask_rect
    end
    mask_rectangles
  end

  def self.make_windows(level, mask_center_rects)
    window_bounding_boxes = [] of Celestine::Rectangle
    window_uses = [] of Celestine::Use

    mask_center_rects.each_with_index do |center_mask_rect, index|
      # Makes windows
      window_x_left = center_mask_rect.left - LEVEL_DATA[level][:block_size]
      window_x_right = center_mask_rect.right

      [window_x_left, window_x_right].each_with_index do |window_x, window_side|
        while (window_side == 0 && window_x > 0) || (window_side == 1 && (window_x + LEVEL_DATA[level][:block_size]) < WIDTH)
          if (@@perlin.int(window_x, window_side + center_mask_rect.top + 1, 0, 100, 4.2929) < 80)
            scale_multiplier = @@perlin.prng_int(window_x, level, window_side + center_mask_rect.top, 1, 3, WINDOW_SCALE_SEED)
            window = Celestine::Rectangle.new
            window.width = LEVEL_DATA[level][:block_size]*scale_multiplier
            window.height = LEVEL_DATA[level][:block_size]*scale_multiplier
            window.x = window_x
            window.y = center_mask_rect.top

            if window.bottom < FRAME_HEIGHT && !Celestine::Collision.check?(window, mask_center_rects) && !Celestine::Collision.check?(window, window_bounding_boxes)
              window_bounding_boxes << window
              use = Celestine::Use.new(@@perlin.prng_item(level, window_x.to_i, window_side + center_mask_rect.top, window_assets[level], WINDOW_ASSET_SEED))
              use.transform { |t| t.translate(window_x, center_mask_rect.top); t.scale(scale_multiplier, scale_multiplier); t }
              window_uses << use
            end
          end
          if window_side == 0
            window_x -= LEVEL_DATA[level][:block_size]
          else
            window_x += LEVEL_DATA[level][:block_size]
          end
        end
      end
    end
    window_uses
  end

  def self.make_ropes(level, mask_center_rects)
    rope_rectangles = [] of Celestine::Rectangle
    mask_center_rects.each_with_index do |center_mask_rect, index|
      # Creates rope points
      points = [] of Int32
      rope_x_padding = (LEVEL_DATA[level][:block_size]*0.5).to_i
      4.times do |x|
        points << @@perlin.prng_int(level, index + x, center_mask_rect.left + rope_x_padding, center_mask_rect.right - rope_x_padding, 0.0695098_f32*(level + 1))
      end

      min_rope_segment = (LEVEL_DATA[level][:block_size]/2).to_i
      max_rope_segment = LEVEL_DATA[level][:block_size] - (LEVEL_DATA[level][:block_size]*0.25).to_i
      max_rope_height = LEVEL_DATA[level][:block_size] * (MAX_LEVELS - level)*3

      # Ensure rope has something to hang from
      points.each do |x|
        rope_width = (level*0.25)*@@perlin.prng_int(level + x, index + x, 1, 4, 0.32323) + 1
        if (index != 0 && !Celestine::Collision.check?(mask_center_rects, Celestine::FPoint.new(x, center_mask_rect.top - 5)) && !Celestine::Collision.check?(mask_center_rects, Celestine::FPoint.new(x + rope_width, center_mask_rect.top - 5)))
          rope = Celestine::Rectangle.new
          rope.x = x
          rope.y = center_mask_rect.top - 1

          rope.width = rope_width
          rope.fill = "white"

          rope_end_point = Celestine::FPoint.new(x, rope.y.to_i + min_rope_segment)
          rope_height = 0
          while (rope_height + LEVEL_DATA[level][:block_size] < max_rope_height) &&
                Celestine::Collision.check?(mask_center_rects, Celestine::FPoint.new(rope_end_point.x, rope_end_point.y + LEVEL_DATA[level][:block_size])) &&
                @@perlin.prng_int(level + x, rope_height + 1, 0, 100) < 80
            rope_height += LEVEL_DATA[level][:block_size]
            rope_end_point = Celestine::FPoint.new(rope_end_point.x, rope_end_point.y + LEVEL_DATA[level][:block_size])
          end

          rope.height = rope_height + @@perlin.prng_int(level, index, min_rope_segment, max_rope_segment, 0.765543_f32*(level + 1))
          rope_rectangles << rope
        end
      end
    end
    rope_rectangles
  end

  def self.make_bridges(level, mask_center_rects)
    bridge_bounding_boxes = [] of Celestine::Rectangle
    bridge_paths = [] of Celestine::Path

    # Makes the windows, ropes, and bridges

    mask_center_rects.each_with_index do |rect, index|
      # Draw bridges, but only level 0 and 1
      if level < 2
        # Center point for the bridge
        mask_center_point = Celestine::FPoint.new(rect.x.to_f + rect.width.to_f/2, rect.y.to_f + rect.height.to_f/2)
        # Angle the bridge is rotated at
        bridge_angle = @@perlin.prng_int(level, index, -30, 30, 0.83772)
        # Height of the bridge
        bridge_height = @@perlin.prng_int(level, index, (LEVEL_DATA[level][:block_size]*0.20).to_i, (LEVEL_DATA[level][:block_size]*0.75).to_i, 0.83772)

        # Top point above the center of the bridge
        bridge_center_top_point = Celestine::FPoint.new(mask_center_point.x, (mask_center_point.y - bridge_height/2))
        # Bottom point above the center of the bridge
        bridge_center_bottom_point = Celestine::FPoint.new(mask_center_point.x, (mask_center_point.y + bridge_height/2))

        bridge_collision_seg_size = LEVEL_DATA[level][:block_size]*0.08

        bridge_slope = Celestine::Math.rotate_point(bridge_collision_seg_size, 0, 0, 0, bridge_angle)
        left_top_point = bridge_center_top_point

        # Shoot out a ray to see if there is a collision
        while left_top_point.x > 0 && left_top_point.y > 0 && left_top_point.y < FRAME_HEIGHT && Celestine::Collision.check?(mask_center_rects, left_top_point)
          left_top_point = Celestine::FPoint.new(
            x: (left_top_point.x - bridge_slope.x),
            y: (left_top_point.y - bridge_slope.y),
          )
        end

        if !Celestine::Collision.check?(mask_center_rects, left_top_point)
          left_bot_point = Celestine::FPoint.new(
            x: left_top_point.x,
            y: (left_top_point.y + bridge_height),
          )

          if !Celestine::Collision.check?(mask_center_rects, left_bot_point)
            right_top_point = bridge_center_top_point
            while right_top_point.x < WIDTH && right_top_point.y > 0 && right_top_point.y < FRAME_HEIGHT && Celestine::Collision.check?(mask_center_rects, right_top_point)
              right_top_point = Celestine::FPoint.new(
                x: (right_top_point.x + bridge_slope.x),
                y: (right_top_point.y + bridge_slope.y),
              )
            end

            if !Celestine::Collision.check?(mask_center_rects, right_top_point)
              right_bot_point = Celestine::FPoint.new(
                x: right_top_point.x,
                y: (right_top_point.y + bridge_height),
              )

              if !Celestine::Collision.check?(mask_center_rects, right_bot_point)
                bb = Celestine::Rectangle.new
                if left_top_point.y < right_top_point.y
                  bb.x = left_top_point.x.to_i
                  bb.y = left_top_point.y.to_i
                  bb.width = (right_top_point.x - left_top_point.x).to_i
                  bb.height = (right_bot_point.y - left_top_point.y).to_i
                else
                  bb.x = left_top_point.x.to_i
                  bb.y = right_top_point.y.to_i
                  bb.width = (right_top_point.x - left_top_point.x).to_i
                  bb.height = (left_bot_point.y - right_top_point.y).to_i
                end

                if !Celestine::Collision.check?(bb, bridge_bounding_boxes)
                  bb.fill = "none"
                  bb.stroke = "magenta"

                  bridge_bounding_boxes << bb

                  # We can draw a bridge here!
                  path = Celestine::Path.new
                  path.a_move(left_top_point.x - 1, left_top_point.y)
                  path.a_line(left_bot_point.x - 1, left_bot_point.y)
                  path.a_line(right_bot_point.x + 1, right_bot_point.y)
                  path.a_line(right_top_point.x + 1, right_top_point.y)
                  path.close
                  path.fill = "white"
                  bridge_paths << path
                end
              end
            end
          end
        end
      end
    end
    bridge_paths
  end

  def self.make
    @@perlin = PerlinNoise.new(@@seed.to_i)
    colors = @@perlin.prng_item(100, 100, COLORS)

    Celestine.draw do |ctx|
      ctx.view_box = {x: 0, y: 0, w: WIDTH, h: HEIGHT}
      ctx.shape_rendering = "optimizeSpeed" # Try to fix firefox svg render stutter. :(

      # Draws a simple white box that allows all pixels through (until we mask on top with black)
      bg_mask = ctx.rectangle(define: true) do |r|
        r.id = "bg-mask"
        r.x = 0
        r.y = 0
        r.width = WIDTH
        r.height = FRAME_HEIGHT
        r.fill = "white"
        r
      end

      # Draw background
      ctx.rectangle do |rect|
        rect.id = "background"
        rect.x = 0
        rect.y = 0
        rect.width = WIDTH
        rect.height = HEIGHT
        rect.fill = colors[:bg]
        rect
      end

      make_window_assets(ctx)

      MAX_LEVELS.times do |level|
        mask = ctx.mask do |mask|
          mask.id = "lvl#{level}-mask"

          mask.use(bg_mask)

          center_rectangles = make_center_mask_rectangles(level)

          center_rectangles.each { |r| mask << r }

          make_windows(level, center_rectangles).each { |w| mask << w }

          make_ropes(level, center_rectangles).each { |w| mask << w }

          make_bridges(level, center_rectangles).each { |w| mask << w }

          ctx.group do |group|
            lvl_rect = group.rectangle do |rect|
              rect.id = "lvl#{level}-rect"
              rect.x = 0
              rect.y = -1
              rect.width = WIDTH
              rect.height = FRAME_HEIGHT + 1
              rect.fill = colors[:levels][level]
              rect.set_mask mask
              group.animate_motion do |anim|
                anim.duration = ((((3 - level)/3.0)*200) + 40).s
                anim.repeat_count = "indefinite"
                anim.mpath do |path|
                  path.r_move(0, 0)
                  path.r_line(0, -FRAME_HEIGHT - 1)
                  path
                end
                anim
              end
              rect
            end

            group.use(lvl_rect) do |use|
              use.y = (FRAME_HEIGHT) - 2
              use
            end

            group
          end
          mask
        end
      end
    end
  end
end