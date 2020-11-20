require "./celestine"
File.open("./logo/logo.svg", "w+") do |f|
  f.puts(Celestine.draw do |ctx|
    ctx.height = 200
    ctx.width = 200
    ctx.view_box = {x: 0, y: 0, w: 200, h: 200}

    oval_half_path = Celestine::Path.new
    oval_half_path.a_move(100, 10)
    # oval_half_path.r_arc(0, 180, 20, 40)
    # oval_half_path.r_arc(0, -180, 20, 40)
    oval_half_path.r_bcurve(-50, 100, -50, 100, 0, 180)
    oval_half_path.r_bcurve(50, -100, 50, -100, 0, -180)
    oval_half_path.stroke = "#5D737E"
    oval_half_path.stroke_width = 3

    oval_half_path.fill = "#C0FDFB"

    oval_half_path.transform do |t|
      t.rotate(40, 100, 100)
      t
    end

    ctx << oval_half_path

    ctx.text do |text|
      text.text = "C"
      text.x = 87
      text.y = 110
      text.style["font-size"] = "40px"
      text.fill = "#64B6AC"

      text
    end
  end)
end