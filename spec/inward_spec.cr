it "should make 10 inward images" do
  10.times do
    Celestine::Test::Inward.make
    Celestine::Test::Inward.seed += 1
  end
  Celestine::Test::Inward.seed = 0
end