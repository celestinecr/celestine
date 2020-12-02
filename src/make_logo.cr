require "./celestine"

module Celestine::Logo
  MASK_SHAPE_ID      = "hex-mask"
  BACKGROUND_RECT_ID = "bg-rect"
  SHADE_L_ID         = "shade-path-l"
  SHADE_R_ID         = "shade-path-r"
  SHADE_OFFSET       =  65
  HEX_RADIUS         = 150
  COLORS             = ["#73B8FC", "#3799FB", "#0466C8", "#0353A4", "#023E7D", "#002855", "#001233"]
  SCREEN_SIZE = 500
  BLEND_MODE = "difference"
  PRECISION = 1
  ARC_PRECISION = 4

  def self.make_arc(start_angle, end_angle, distance, thickness = 10, large = false, flip = false)
    p1 = Celestine::FPoint.new(0 + 250, distance + 250)
    p2 = Celestine::FPoint.new(0 + 250, distance + thickness + 250)

    p1_t1 = Celestine::Math.rotate_point(p1.x, p1.y, SCREEN_SIZE/2.0, SCREEN_SIZE/2.0, start_angle)
    p2_t1 = Celestine::Math.rotate_point(p2.x, p2.y, SCREEN_SIZE/2.0, SCREEN_SIZE/2.0, end_angle)

    path = Celestine::Path.new
    path.a_move(p1_t1.x, p1_t1.y)

    current_p1_angle = start_angle
    while current_p1_angle <= end_angle
      current_p1_angle = end_angle if current_p1_angle > end_angle
      p1_r1 = Celestine::Math.rotate_point(p1.x, p1.y, SCREEN_SIZE/2.0, SCREEN_SIZE/2.0, current_p1_angle)
      path.a_line(p1_r1.x.round(PRECISION), p1_r1.y.round(PRECISION))
      current_p1_angle += ARC_PRECISION
    end
    path.a_line(p2_t1.x.round(PRECISION), p2_t1.y.round(PRECISION))

    current_p2_angle = end_angle
    while current_p2_angle >= start_angle
      current_p2_angle = start_angle if current_p2_angle < start_angle
      p2_r1 = Celestine::Math.rotate_point(p2.x, p2.y, SCREEN_SIZE/2.0, SCREEN_SIZE/2.0, current_p2_angle)
      path.a_line(p2_r1.x.round(PRECISION), p2_r1.y.round(PRECISION))
      current_p2_angle -= ARC_PRECISION
    end

    path.close

    path
  end
end

extend Celestine::Logo

File.open("./logo/logo.svg", "w+") do |f|
  f.puts(Celestine.draw do |ctx|
    ctx.height = 500
    ctx.height_units = ctx.width_units = "px"
    ctx.width = 500

    ctx.view_box = {x: 0, y: 0, w: 500, h: 500}

    ctx.path(define: true) do |path|
      path.id = MASK_SHAPE_ID

      path.a_move(0, HEX_RADIUS)

      6.times do |x|
        point = Celestine::FPoint.new(0, HEX_RADIUS)
        deg_inc = 360.to_f/6
        rp = Celestine::Math.rotate_point(point, Celestine::FPoint::ZERO, deg_inc*x)
        path.a_line(rp.x.floor, rp.y.floor)
      end

      path.transform do |t|
        t.translate(250, 250)
        t
      end

      path
    end

    ctx.rectangle(define: true) do |r|
      r.id = BACKGROUND_RECT_ID
      r.width = 500
      r.height = 500
      r
    end

    ctx.mask do |mask|
      mask.id = "mask"

      mask.use(BACKGROUND_RECT_ID) { |r| r.fill = "white"; r }
      mask.use(MASK_SHAPE_ID) do |r|
        r.fill = "black"

        r
      end

      mask
    end
    ctx.use(BACKGROUND_RECT_ID) { |r| r.fill = COLORS[0]; r }

    4.times do |index|
      offset = SHADE_OFFSET * index
      ctx.path(define: true) do |path|
        path.id = SHADE_L_ID + index.to_s
        path.fill = "black"
        path.opacity = 0.2

        p1 = Celestine::FPoint.new(1000, 0)
        p2 = Celestine::Math.rotate_point(p1, Celestine::FPoint::ZERO, 30)

        path.a_move(0, 0 + offset)
        path.a_line(p2.x.round(PRECISION), p2.y.round(PRECISION) + offset)
        path.a_v_line 500 + offset
        path.a_h_line 0
        path.close

        path
      end
    end

    4.times do |index|
      offset = SHADE_OFFSET * index
      animate = Celestine::Animate.new
      animate.attribute = "y"


      animate.values << 300
      animate.values << 0

      animate.custom_attrs["keySplines"] = "0 1 0.79 0.99 ;"
      


      animate.duration = 3 + (index*2)
      animate.freeze = true

      ctx.use(SHADE_L_ID + index.to_s) do |u|
        animate.draw(u.inner_elements)
        #u.style["mix-blend-mode"] = BLEND_MODE
        u
      end

      ctx.use(SHADE_L_ID + index.to_s) do |u|
        u.transform do |t|
          t.scale(-1, 1)
          t.translate(-500, 0)
          t
        end
        animate.draw(u.inner_elements)
        #u.style["mix-blend-mode"] = BLEND_MODE
        u
      end
    end

    ctx.use(BACKGROUND_RECT_ID) { |r| r.fill = "white"; r.set_mask("mask"); r }

    ctx.group do |g|
      c_outline = Celestine::Logo.make_arc(300, 600, 90, 25)
      c_outline.fill = "black"
      g << c_outline

      c_inline = Celestine::Logo.make_arc(300 + 3, 600 - 3, 95, 15)
      c_inline.fill = "white"
      g << c_inline

      g.animate do |a|
        a.attribute = "opacity"
        a.values << 0
        a.values << 0
        a.values << 1.0

        a.key_times << 0
        a.key_times << 0.81
        a.key_times << 1.0

        a.duration = 13
        a.freeze = true
        a
      end
      g
    end
  end)
end
