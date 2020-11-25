require "./celestine"

File.open("./bin/test.svg", "w+") do |f|
  Celestine.draw(f) do |ctx|
    ctx.view_box = {x: 0, y: 0, w: 500, h: 500}

    ctx.circle do |circle|
      circle.x = 150
      circle.y = 150
      circle.radius = 50
      circle.fill = "blue"
      circle
    end

    ctx.circle do |circle|
      circle.x = 200
      circle.y = 200
      circle.radius = 50
      circle.fill = "green"

      blur_filter = ctx.filter do |filter|
        filter.id = "blur-filter"
        filter.x = -500
        filter.y = -500
        filter.width = 1000
        filter.height = 1000
        filter.blur do |blur|
          blur.edge_mode = "none"
          blur.input = Celestine::Filter::SOURCE_GRAPHIC
          blur.animate do |a|
            a.attribute = Celestine::Filter::Blur::Attrs::STANDARD_DEVIATION
            a.values << 0
            a.values << 10
            a.values << 0
            a.duration = 6.s
            a.repeat_count = "indefinite"
            a
          end
          blur
        end
        filter
      end

      circle.set_filter blur_filter

      circle
    end
  end
end