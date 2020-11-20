require "benchmark"
require "file_utils"
require "perlin_noise"

require "./celestine"
require "./test/**"

puts
puts

puts "IPS simple"
Benchmark.ips do |x|
  x.report("inward") do
    Celestine::Test::Inward.make
    Celestine::Test::Inward.seed = 0
  end

  x.report("mineshift") do
    Celestine::Test::Mineshift.make
    Celestine::Test::Mineshift.seed = 0
  end
end

puts
puts "IPS complex"
Benchmark.ips(warmup: 4, calculation: 10) do |x|
  x.report("inward") do
    Celestine::Test::Inward.make
    Celestine::Test::Inward.seed = 0
  end

  x.report("mineshift") do
    Celestine::Test::Mineshift.make
    Celestine::Test::Mineshift.seed = 0
  end
end

puts
puts
Benchmark.bm do |x|
  x.report("inward 10") do
    10.times do
      Celestine::Test::Inward.make
      Celestine::Test::Inward.seed += 1
    end
    Celestine::Test::Inward.seed = 0
  end

  x.report("inward 100") do
    100.times do |x|
      Celestine::Test::Inward.make
      Celestine::Test::Inward.seed += 1
    end
    Celestine::Test::Inward.seed = 0
  end

  x.report("inward 1000") do
    1000.times do |x|
      Celestine::Test::Inward.make
      Celestine::Test::Inward.seed += 1
    end
    Celestine::Test::Inward.seed = 0
  end

  x.report("mineshift 10") do
    10.times do |x|
      Celestine::Test::Mineshift.make
      Celestine::Test::Mineshift.seed += 1
    end
    Celestine::Test::Mineshift.seed = 0
  end

  x.report("mineshift 100") do
    100.times do |x|
      Celestine::Test::Mineshift.make
      Celestine::Test::Mineshift.seed += 1
    end
    Celestine::Test::Mineshift.seed = 0
  end

  x.report("mineshift 1000") do
    1000.times do |x|
      Celestine::Test::Mineshift.make_new_img
      Celestine::Test::Mineshift.seed += 1
    end
    Celestine::Test::Mineshift.seed = 0
  end
end
