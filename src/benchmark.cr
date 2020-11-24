require "benchmark"
require "file_utils"
# You need to re-add this to your shard.yml if you want this to work for release!
require "perlin_noise"

require "./celestine"
require "./test/**"

puts
puts

puts "IPS simple"
Benchmark.ips do |x|
  x.report("inward") do
    ProceduralArt::Inward.make
    ProceduralArt::Inward.seed = 0
  end

  x.report("mineshift-simple") do
    ProceduralArt::Mineshift::Simple.make
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex") do
    ProceduralArt::Mineshift::Complex.make
    ProceduralArt::Mineshift::Complex.seed = 0
  end
end

puts
puts "IPS complex"
Benchmark.ips(warmup: 4, calculation: 10) do |x|
  x.report("inward") do
    ProceduralArt::Inward.make
    ProceduralArt::Inward.seed = 0
  end

  x.report("mineshift-simple") do
    ProceduralArt::Mineshift::Simple.make
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex") do
    ProceduralArt::Mineshift::Complex.make
    ProceduralArt::Mineshift::Complex.seed = 0
  end
end

puts
puts
Benchmark.bm do |x|
  x.report("inward 1") do
    1.times do
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  x.report("inward 10") do
    10.times do
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  x.report("inward 100") do
    100.times do |x|
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  x.report("inward 1000") do
    1000.times do |x|
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  x.report("inward 10000") do
    10000.times do |x|
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  x.report("mineshift-simple 1") do
    1.times do |x|
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  
  x.report("mineshift-simple 5") do
    5.times do |x|
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 10") do
    10.times do |x|
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 100") do
    100.times do |x|
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 1000") do
    1000.times do |x|
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex 1") do
    1.times do |x|
      ProceduralArt::Mineshift::Complex.make
      ProceduralArt::Mineshift::Complex.seed += 1
    end
    ProceduralArt::Mineshift::Complex.seed = 0
  end

  
  x.report("mineshift-complex 5") do
    5.times do |x|
      ProceduralArt::Mineshift::Complex.make
      ProceduralArt::Mineshift::Complex.seed += 1
    end
    ProceduralArt::Mineshift::Complex.seed = 0
  end

  x.report("mineshift-complex 10") do
    10.times do |x|
      ProceduralArt::Mineshift::Complex.make
      ProceduralArt::Mineshift::Complex.seed += 1
    end
    ProceduralArt::Mineshift::Complex.seed = 0
  end

  
  x.report("mineshift-complex 50") do
    50.times do |x|
      ProceduralArt::Mineshift::Complex.make
      ProceduralArt::Mineshift::Complex.seed += 1
    end
    ProceduralArt::Mineshift::Complex.seed = 0
  end
end

