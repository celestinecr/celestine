require "celestine"

Celestine.draw do |ctx|
  ctx.mask do |m|
    m.id = "our-mask"
    m.rectangle do |r|
      r.x = 10
      r.y = 20
      r.width = r.height = 40
      r.fill = "black"
      r
    end
    m
  end

  ctx.rectangle do |r|
    r.x = 0
    r.y = 0
    r.width = 200
    r.height = 200
    r.fill = "blue"
    r
  end

  ctx.rectangle do |r|
    r.set_mask "our-mask"
    r.x = 0
    r.y = 0
    r.width = 200
    r.height = 200
    r.fill = "red"
    r
  end
end