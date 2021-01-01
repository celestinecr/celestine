require "./celestine"

require "procedural_art"
require "benchmark"

PROC_ART_ITERATIONS =    1000
SVG_NESTED_DEPTH    =   10000
SVG_MAX_OBJECTS     = 1000000

Benchmark.bm do |benchmark|
  benchmark.report("Add objects") do
    Celestine.draw do |ctx|
      SVG_MAX_OBJECTS.times do
        ctx.rectangle { |r| r.x = 100; r.y = 200; r }
      end
    end
  end

  benchmark.report("Nest objects") do
    Celestine.draw do |ctx|
      svg = Celestine::Svg.new

      SVG_NESTED_DEPTH.times do
        new_svg = Celestine::Svg.new
        new_svg << svg
        svg = new_svg

        Celestine.draw do |ctx|
          ctx << svg
        end
      end
    end
  end
end

puts

Benchmark.bm do |benchmark|
  benchmark.report("Hypnos #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::Hypnos.make
    end
  end

  benchmark.report("Inward #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
  end

  benchmark.report("Mineshift-S #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
  end

  benchmark.report("Chromatic #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::ChromaticAberration.make
      ProceduralArt::ChromaticAberration.seed += 1
    end
  end

  benchmark.report("Patchwork #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::SemiCirclePatchwork.make
      ProceduralArt::SemiCirclePatchwork.seed += 1
    end
  end

  benchmark.report("Splash #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::SplashEffect.make
    end
  end

  benchmark.report("PsychoFlower #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::PsychoFlower.make
    end
  end

  benchmark.report("Polarspins #{PROC_ART_ITERATIONS}") do
    PROC_ART_ITERATIONS.times do
      ProceduralArt::PolarSpins.make
      ProceduralArt::PolarSpins.seed += 1
    end
  end
end
