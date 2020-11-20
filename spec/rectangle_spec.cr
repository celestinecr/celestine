it "rectangle should set attribute x" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.x = 100; r} } =~ /x\=\"100\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.x = -100; r} } =~ /x\=\"-100\"/)).should eq(true)

end

it "rectangle should set attribute y" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.y = 100; r} } =~ /y\=\"100\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.y = -100; r} } =~ /y\=\"-100\"/)).should eq(true)
end

it "rectangle should set attribute width" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.width = 100; r} } =~ /width\=\"100\"/)).should eq(true)
end

it "rectangle should set attribute height" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.height = 100; r} } =~ /height\=\"100\"/)).should eq(true)
end

it "rectangle should set attribute fill" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "black"; r} } =~ /fill\=\"black\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "red"; r} } =~ /fill\=\"red\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "#121212"; r} } =~ /fill\=\"\#121212\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "#AAAAAA"; r} } =~ /fill\=\"\#AAAAAA\"/)).should eq(true)
end

it "rectangle should set attribute stroke" do
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "black"; r} } =~ /stroke\=\"black\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "red"; r} } =~ /stroke\=\"red\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "#121212"; r} } =~ /stroke\=\"\#121212\"/)).should eq(true)
  (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "#AAAAAA"; r} } =~ /stroke\=\"\#AAAAAA\"/)).should eq(true)
end

