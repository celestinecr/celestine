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

  x.report("mineshift-simple") do
    Celestine::Test::Mineshift::Simple.make
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex") do
    Celestine::Test::Mineshift::Complex.make
    Celestine::Test::Mineshift::Complex.seed = 0
  end
end

puts
puts "IPS complex"
Benchmark.ips(warmup: 4, calculation: 10) do |x|
  x.report("inward") do
    Celestine::Test::Inward.make
    Celestine::Test::Inward.seed = 0
  end

  x.report("mineshift-simple") do
    Celestine::Test::Mineshift::Simple.make
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex") do
    Celestine::Test::Mineshift::Complex.make
    Celestine::Test::Mineshift::Complex.seed = 0
  end
end

puts
puts
Benchmark.bm do |x|
  x.report("inward 1") do
    1.times do
      Celestine::Test::Inward.make
      Celestine::Test::Inward.seed += 1
    end
    Celestine::Test::Inward.seed = 0
  end

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

  x.report("mineshift-simple 1") do
    5.times do |x|
      Celestine::Test::Mineshift::Simple.make
      Celestine::Test::Mineshift::Simple.seed += 1
    end
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  
  x.report("mineshift-simple 5") do
    5.times do |x|
      Celestine::Test::Mineshift::Simple.make
      Celestine::Test::Mineshift::Simple.seed += 1
    end
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 10") do
    10.times do |x|
      Celestine::Test::Mineshift::Simple.make
      Celestine::Test::Mineshift::Simple.seed += 1
    end
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 100") do
    100.times do |x|
      Celestine::Test::Mineshift::Simple.make
      Celestine::Test::Mineshift::Simple.seed += 1
    end
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-simple 1000") do
    1000.times do |x|
      Celestine::Test::Mineshift::Simple.make
      Celestine::Test::Mineshift::Simple.seed += 1
    end
    Celestine::Test::Mineshift::Simple.seed = 0
  end

  x.report("mineshift-complex 1") do
    5.times do |x|
      Celestine::Test::Mineshift::Complex.make
      Celestine::Test::Mineshift::Complex.seed += 1
    end
    Celestine::Test::Mineshift::Complex.seed = 0
  end

  
  x.report("mineshift-complex 5") do
    5.times do |x|
      Celestine::Test::Mineshift::Complex.make
      Celestine::Test::Mineshift::Complex.seed += 1
    end
    Celestine::Test::Mineshift::Complex.seed = 0
  end

  x.report("mineshift-complex 10") do
    10.times do |x|
      Celestine::Test::Mineshift::Complex.make
      Celestine::Test::Mineshift::Complex.seed += 1
    end
    Celestine::Test::Mineshift::Complex.seed = 0
  end

  
  x.report("mineshift-complex 50") do
    50.times do |x|
      Celestine::Test::Mineshift::Complex.make
      Celestine::Test::Mineshift::Complex.seed += 1
    end
    Celestine::Test::Mineshift::Complex.seed = 0
  end
end
