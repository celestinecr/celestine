require "./spec_helper"

describe Celestine::Point do
  it "should add and subtract points" do
    p1 = Celestine::Point.new(10, 20)
    p2 = Celestine::Point.new(5, 8)
    (p1 + p2).should eq(Celestine::Point.new(15, 28))
    (p1 - p2).should eq(Celestine::Point.new(5, 12))
  end

  it "should multiply and integer-divide points" do
    p1 = Celestine::Point.new(12, 18)
    p2 = Celestine::Point.new(3, 6)
    (p1 * p2).should eq(Celestine::Point.new(36, 108))
    (p1 // p2).should eq(Celestine::Point.new(4, 3))
  end

  it "should float-divide points returning an FPoint" do
    p1 = Celestine::Point.new(5, 7)
    p2 = Celestine::Point.new(2, 2)
    result = p1 / p2
    result.should be_a(Celestine::FPoint)
    result.x.should eq(2.5)
    result.y.should eq(3.5)
  end

  it "should support scalar operations on Point" do
    p = Celestine::Point.new(4, 8)
    (p * 2).should eq(Celestine::Point.new(8, 16))
    (p // 2).should eq(Celestine::Point.new(2, 4))
    (p / 2).should eq(Celestine::FPoint.new(2.0, 4.0))
  end
end

describe Celestine::FPoint do
  it "should perform floating point arithmetic" do
    fp1 = Celestine::FPoint.new(1.5, 2.5)
    fp2 = Celestine::FPoint.new(0.5, 1.5)
    (fp1 + fp2).should eq(Celestine::FPoint.new(2.0, 4.0))
    (fp1 - fp2).should eq(Celestine::FPoint.new(1.0, 1.0))
    (fp1 * fp2).should eq(Celestine::FPoint.new(0.75, 3.75))
    (fp1 / fp2).should eq(Celestine::FPoint.new(3.0, 2.5 / 1.5))
  end

  it "should rotate points correctly" do
    rotated = Celestine::Math.rotate_point(10, 0, 0, 0, 90)
    rotated.x.round(2).should eq(0.0)
    rotated.y.round(2).should eq(10.0)
  end
end
