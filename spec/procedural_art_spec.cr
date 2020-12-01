describe ProceduralArt do
  it "should make 10 hypnos images" do
    100.times do
      ProceduralArt::Hypnos.make
    end
  end

  it "should make 10 inward images" do
    10.times do
      ProceduralArt::Inward.make
      ProceduralArt::Inward.seed += 1
    end
    ProceduralArt::Inward.seed = 1
  end

  it "should make 10 mineshift-s images" do
    10.times do
      ProceduralArt::Mineshift::Simple.make
      ProceduralArt::Mineshift::Simple.seed += 1
    end
    ProceduralArt::Mineshift::Simple.seed = 1
  end

  it "should make 10 chromatic images" do
    10.times do
      ProceduralArt::ChromaticAberration.make
      ProceduralArt::ChromaticAberration.seed += 1
    end
    ProceduralArt::ChromaticAberration.seed = 1
  end

  it "should make 10 patchwork images" do
    10.times do
      ProceduralArt::SemiCirclePatchwork.make
      ProceduralArt::SemiCirclePatchwork.seed += 1
    end
    ProceduralArt::SemiCirclePatchwork.seed = 1
  end

  it "should make 1 spash image" do
    ProceduralArt::SplashEffect.make
  end

  it "should make 1 psychoflower image" do
    ProceduralArt::PsychoFlower.make
  end

  it "should make 10 polar_spins images" do
    10.times do
      ProceduralArt::PolarSpins.make
      ProceduralArt::PolarSpins.seed += 1
    end
    ProceduralArt::PolarSpins.seed = 1
  end
end
