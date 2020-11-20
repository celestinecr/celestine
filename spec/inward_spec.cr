require "file_utils"
require "perlin_noise"

class Celestine::Test::Inward
  COLOR_PALETTES = {
    "substantial"     => ["#154148", "#64c5c3", "#e7b576", "#fe8f22"],
    "business"        => ["#222831", "#393e46", "#00adb5", "#eeeeee"],
    "vibrant_sunset"  => ["#f9ed69", "#f08a5d", "#b83b5e", "#6a2c70"],
    "faded_desert"    => ["#f38181", "#fce38a", "#eaffd0", "#95e1d3"],
    "sleek_contrast"  => ["#252a34", "#08d9d6", "#ff2e63", "#eaeaea"],
    "bomb_pop"        => ["#364f6b", "#3fc1c9", "#f5f5f5", "#fc5185"],
    "easter_pastel"   => ["#a8d8ea", "#aa96da", "#fcbad3", "#ffffd2"],
    "misty_morning"   => ["#e3fdfd", "#cbf1f5", "#a6e3e9", "#71c9ce"],
    "future_vision"   => ["#e4f9f5", "#30e3ca", "#11999e", "#40514e"],
    "pass_out"        => ["#f9f7f7", "#cbf1f5", "#a6e3e9", "#71c9ce"],
    "red_river"       => ["#2b2e4a", "#e84545", "#903749", "#53354a"],
    "retro_ideas"     => ["#00b8a9", "#f8f3d4", "#f6416c", "#ffde7d"],
    "deep_sea"        => ["#48466d", "#3d84a8", "#46cdcf", "#abedd8"],
    "trout"           => ["#ffb6b9", "#fae3d9", "#bbded6", "#61c0bf"],
    "mystic_red"      => ["#e23e57", "#88304e", "#522546", "#311d3f"],
    "child_like"      => ["#ffcfdf", "#fefdca", "#e0f9b5", "#a5dee5"],
    "mystic_diamond"  => ["#212121", "#323232", "#0d7377", "#14ffec"],
    "lost_mystery"    => ["#a8e6cf", "#dcedc1", "#ffd3b6", "#ffaaa5"],
    "purple_pastel"   => ["#defcf9", "#cadefc", "#c3bef0", "#cca8e9"],
    "endless_red"     => ["#f67280", "#c06c84", "#6c5b7b", "#355c7d"],
    "salmon_stingray" => ["#ffc8c8", "#ff9999", "#6c5b7b", "#355c7d"],
    "alaskan_salmon"  => ["#ffc8c8", "#ff9999", "#444f5a", "#3e4149"],
    "ideas"           => ["#3ec1d3", "#f6f7d7", "#ff9a00", "#ff165d"],
    "twilight_sunset" => ["#2d4059", "#ea5455", "#f07b3f", "#ffd460"],
    "oceans_heart"    => ["#6fe7dd", "#3490de", "#6639a6", "#521262"],
    "asimov"          => ["#303841", "#00adb5", "#eeeeee", "#ff5722"],
    "seafarer"        => ["#384259", "#f73859", "#7ac7c4", "#c4edde"],
    "negatron"        => ["#f0f5f9", "#c9d6df", "#52616b", "#1e2022"],
    "firework"        => ["#f85f73", "#fbe8d3", "#928a97", "#283c63"],
    "cream_ale"       => ["#07689f", "#a2d5f2", "#fafafa", "#ff7e67"],
  }

  TYPES = ("a".."g")


  @@seed : Int32 = 0

  def self.make_img_path(seed)
    "/test/inward/#{seed}.svg"
  end

  def self.make_new_img
    @@seed &+= 1
    File.open("./bin" + make_img_path(@@seed), "w+") { |f| f.puts self.new(@@seed).make }
  end

  property width = 200
  property height = 100
  property tri_size = 8

  def initialize(seed, @width = 200, @height = 100, @tri_size = 8)
    @perlin = PerlinNoise.new(seed)
  end

  def make
    colors = COLOR_PALETTES[color_name = @perlin.prng_item(2010, 2034, COLOR_PALETTES.keys)].clone
    bg_color = @perlin.prng_item(2211, 2234, colors)
    colors.delete bg_color
    g_type = @perlin.prng_item(3010, 3010, TYPES.to_a)
    d_tri_size = tri_size

    Celestine.draw do |ctx|
      ctx.view_box = {x: 0, y: 0, w: width*tri_size, h: height*tri_size}

      ctx.rectangle do |rect|
        rect.x = 0
        rect.y = 0
        rect.width = width*tri_size
        rect.height = height*tri_size
        rect.fill = bg_color
        rect
      end

      quarter_image = ctx.group(define: true) do |group|
        group.id = "quarter-image-#{@perlin.seed}"

        5.times do |g|
          a1x = 0
          a1y = d_tri_size
          a2x = d_tri_size
          a2y = d_tri_size
          a3x = d_tri_size
          a3y = 0

          tri = ctx.path(define: true) do |path|
            path.id = "tri#{g}-#{@perlin.seed}"
            path.stroke_width = 0
            path.a_move a1x, a1y
            path.a_line a2x, a2y
            path.a_line a3x, a3y
            path.close
            path
          end

          layer = ctx.group(define: true) do |layer|
            layer.id = "layer#{g}-#{@perlin.seed}"
            (width/(2**g)/2.0).to_i.times do |x|
              (height/(2**g)/2.0).to_i.times do |y|
                x_com = x
                y_com = y
                chance = 0
                color = "#ffffff"

                case g_type
                when "a"
                  x_com = (x & y)
                  y_com = (y & x)
                  chance = @perlin.prng_int(x_com, y_com, 2, 20)
                  color = @perlin.prng_item(x_com + g, y_com + g, colors)
                when "b"
                  x_com = (x | y)
                  y_com = (y | x)
                  chance = @perlin.prng_int(x_com, y_com, 2, 20)
                  color = @perlin.prng_item(x_com + g, y_com, colors)
                when "c"
                  x_com = (x ^ y)
                  y_com = (y ^ x)
                  chance = @perlin.prng_int(x_com, y_com, 2, 20)
                  color = @perlin.item(x_com + g, y_com, colors)
                when "d"
                  x_com = (x << y)
                  y_com = (y << x)
                  chance = @perlin.int(x_com, y_com, 2, 20)
                  color = @perlin.item(x_com + g, y_com + g, colors)
                when "e"
                  x_com = (x >> y)
                  y_com = (y >> x)
                  chance = 1 + g
                  color = @perlin.prng_item(x_com + g, y_com, colors)
                when "f"
                  x_com = (x << y)
                  y_com = (y >> x)
                  chance = @perlin.prng_int(x_com, y_com, 2, 8)
                  color = @perlin.prng_item(x_com + g, y_com + g, colors)
                when "g"
                  x_com = (x << y)
                  y_com = (y >> x)
                  chance = @perlin.prng_int(x_com, y_com, 2, 8)
                  color = @perlin.prng_item(x_com, y_com, colors)
                end

                if chance == 1 || @perlin.prng_int(x_com, y_com, 0, chance, 0.1234) == 0
                  layer.use(tri) do |tri|
                    tri.x = x * d_tri_size
                    tri.y = y * d_tri_size
                    tri.fill = color
                    tri
                  end
                end
              end
            end
            layer
          end
          group.use(layer)
          d_tri_size *= 2
        end
        group
      end

      ctx.use(quarter_image)
      ctx.use(quarter_image) do |g|
        g.transform do |t|
          t.scale(-1, 1)
          t.translate(-1600 + 0.5, 0)
          t
        end
        g
      end

      ctx.use(quarter_image) do |g|
        g.transform do |t|
          t.scale(-1, -1)
          t.translate(-1600 + 0.5, -800 + 0.5)
          t
        end
        g
      end

      ctx.use(quarter_image) do |g|
        g.transform do |t|
          t.scale(1, -1)
          t.translate(0, -800 + 0.5)
          t
        end
        g
      end
    end
  end
end

it "should make 10 inward images" do
  FileUtils.rm_rf "./bin/test/inward/"
  FileUtils.mkdir_p "./bin/test/inward/"
  10.times do
    Celestine::Test::Inward.make_new_img
  end
end