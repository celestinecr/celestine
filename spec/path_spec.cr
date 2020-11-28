describe Celestine::Path do
  it "should fill up path code using DSL" do
    path = Celestine::Path.new
    path.a_move(0, 0)
    path.close
    path.code.should eq("M0,0z")
  end
end