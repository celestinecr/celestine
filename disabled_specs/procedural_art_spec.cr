describe ProceduralArt do
  it "should make 100 hypnos images" do
    100.times do
      ProceduralArt::Hypnos.make
    end
  end

  it "should make 10 inward images" do
    10.times do
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 0
  end

  it "should make 10 mineshift-s images" do
    10.times do
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 0
  end

  it "should make 5 mineshift-c images" do
    5.times do |x|
      ProceduralArt::Mineshift::Complex.make
      ProceduralArt::Mineshift::Complex.seed += 1
    end
    ProceduralArt::Mineshift::Complex.seed = 0
  end
end
