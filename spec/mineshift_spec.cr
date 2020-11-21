it "should make 10 mineshift images" do
  10.times do
    Celestine::Test::Mineshift::Simple.make
    Celestine::Test::Mineshift::Simple.seed += 1
  end
  Celestine::Test::Mineshift::Simple.seed = 0
end

it "should make 10 mineshift images" do
  10.times do
    Celestine::Test::Mineshift::Complex.make
    Celestine::Test::Mineshift::Complex.seed += 1
  end
  Celestine::Test::Mineshift::Complex.seed = 0
end