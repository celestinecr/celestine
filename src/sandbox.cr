require "file_utils"
require "perlin_noise"

require "./celestine"
require "./test/**"

File.open("./bin/test/test.svg", "w+") do |f|
  f.puts ProceduralArt::Hypnos.make
end