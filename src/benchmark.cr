require "./celestine"
require "benchmark"

SVG_NESTED_DEPTH =   1000
SVG_MAX_OBJECTS  = 100000

Benchmark.bm do |benchmark|
  benchmark.report("Add objects (#{SVG_MAX_OBJECTS})") do
    Celestine.draw do |ctx|
      SVG_MAX_OBJECTS.times do
        ctx.rectangle { |r| r.x = 100; r.y = 200; r }
      end
    end
  end

  benchmark.report("Nest objects (#{SVG_NESTED_DEPTH})") do
    Celestine.draw do |ctx|
      svg = Celestine::Svg.new

      SVG_NESTED_DEPTH.times do
        new_svg = Celestine::Svg.new
        new_svg << svg
        svg = new_svg

        Celestine.draw do |c|
          c << svg
        end
      end
    end
  end
end
