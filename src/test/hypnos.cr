module Celestine::Test::Hypnos
  SIZE = 500
  SIDES = [0, 3, 4, 5, 6, 7, 8]
  FG_MASK_ID = "fg-mask"
  BG_MASK_ID = "bg-mask"
  FG_MASK_RADIUS = 140.0

  MAX_STROKE_WIDTH = 5
  CIRCLE_SPACING = 10
  MAX_CIRCLE_SIZE = FG_MASK_RADIUS + (CIRCLE_SPACING * 2)

  def self.make
    sides = SIDES.sample

    Celestine.draw do |ctx|
      ctx.view_box = {x: 0, y: 0, w: 500, h: 500}

      bg_mask = ctx.rectangle(define: true) do |r|
        r.id = BG_MASK_ID
        r.x = 0
        r.y = 0
        r.width = 500
        r.height = 500
        r.fill = "black"
        r.stroke = "none"
        r
      end

      ctx.rectangle do |r|
        r.id = "bg"
        r.x = 0
        r.y = 0
        r.width = 500
        r.height = 500
        r.fill = "white"
        r.stroke = "none"
        r
      end

      fg_mask = if sides == 0
        ctx.circle(define: true) do |c|
          c.id = FG_MASK_ID
          c.x = SIZE/2
          c.y = c.x
          c.radius = FG_MASK_RADIUS
          c.fill = "white"

          c
        end
      else
        ctx.path(define: true) do |path|
          path.id = FG_MASK_ID

          path.fill = "white"
          path.a_move(0, FG_MASK_RADIUS)

          sides.times do |x|
            point = Celestine::FPoint.new(0, FG_MASK_RADIUS)
            deg_inc = 360.to_f/sides
            rp = Celestine::Math.rotate_point(point, Celestine::FPoint::ZERO, deg_inc*x)
            path.a_line(rp.x.floor, rp.y.floor)
          end

          path.transform do |t|
            t.translate(250, 250)
            t
          end

          path
        end
      end

      mask = ctx.mask do |mask|
        mask.id = "mask"
        mask.use bg_mask
        mask.use(fg_mask) do |u|
          u.animate_transform do |anim|
            anim.type = "rotate"
            anim.from = "0 250 250"
            anim.to = "360 250 250"
            anim.duration = "10s"
            anim.repeat_count = "indefinite"
            anim
          end
          u
        end
        mask
      end

      ctx.group do |group|
        group.id = "concentric-circles"
        group.set_mask mask
        
        (MAX_CIRCLE_SIZE / CIRCLE_SPACING.to_f).to_i.times do |x|
          circle = Celestine::Circle.new
          circle.stroke = "black"
          circle.fill = "none"
          circle.x = circle.y = SIZE/2
          if x.zero?
            circle.animate do |anim|
              anim.attribute = Celestine::Circle::Attrs::STROKE_WIDTH
              anim.duration = "5s"
              anim.values = [0, MAX_STROKE_WIDTH.px, MAX_STROKE_WIDTH.px] of SIFNumber
              anim.repeat_count = "indefinite"
              anim
            end

            circle.animate do |anim|
              anim.attribute = Celestine::Circle::Attrs::RADIUS
              anim.duration = "5s"
              anim.from = 0
              anim.to = 10.px
              anim.repeat_count = "indefinite"
              anim
            end

            group << circle

            circle2 = Celestine::Circle.new
            circle2.stroke_width = MAX_STROKE_WIDTH.px
            circle2.stroke = "red"
            circle2.fill = "none"
            circle2.x = circle2.y = SIZE/2
            circle2.animate do |anim|
              anim.attribute = Celestine::Circle::Attrs::RADIUS
              anim.duration = "5s"
              anim.from = 0
              anim.to = CIRCLE_SPACING
              anim.repeat_count = "indefinite"
              anim
            end
          else
            circle.stroke_width = MAX_STROKE_WIDTH.px

            circle.animate do |anim|
              anim.attribute = Celestine::Circle::Attrs::RADIUS
              anim.duration = "5s"
              anim.from = x * CIRCLE_SPACING
              anim.to = (x+1) * CIRCLE_SPACING
              anim.repeat_count = "indefinite"
              anim
            end
          end
          group << circle.dup
        end
        group
      end
    end
  end
end