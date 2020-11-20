it "should make 10 inward images" do
  FileUtils.rm_rf "./bin/test/inward/"
  FileUtils.mkdir_p "./bin/test/inward/"
  10.times do
    Celestine::Test::Inward.make
    Celestine::Test::Inward.seed += 1
  end
  Celestine::Test::Inward.seed = 0
end