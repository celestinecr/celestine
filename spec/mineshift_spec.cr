it "should make 10 mineshift images" do
  FileUtils.rm_rf "./bin/test/mineshift/"
  FileUtils.mkdir_p "./bin/test/mineshift/"
  10.times do
    Celestine::Test::Mineshift.make
    Celestine::Test::Mineshift.seed += 1
  end
  Celestine::Test::Mineshift.seed = 0
end