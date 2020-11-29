describe Celestine::Path do
  it "should fill up path code using DSL" do
    path = Celestine::Path.new
    path.a_move(0, 0)
    path.close
    path.code.should eq("M0,0z")
  end

  it "should be able to use all path code instructions using DSL" do
    path = Celestine::Path.new
    path.a_move(1, 2)
    path.r_move(3, 4)
    path.a_line(5, 6)
    path.r_line(7, 8)
    path.a_arc(9, 10, 11, 12)
    path.r_arc(13, 14, 15, 16)
    path.a_v_line(17)
    path.r_v_line(18)
    path.a_h_line(19)
    path.r_h_line(20)
    path.a_bcurve(21, 22, 23, 24, 25, 26)
    path.r_bcurve(27, 28, 29, 30, 31, 32)
    path.a_q_bcurve(33, 34, 35, 36)
    path.r_q_bcurve(37, 38, 39, 40)
    path.a_s_bcurve(41, 42, 43, 44)
    path.r_s_bcurve(45, 46, 47, 48)
    path.a_t_bcurve(49, 50)
    path.r_t_bcurve(51, 52)
    path.close
    path.code.should eq("M1,2m3,4L5,6l7,8A11,12,0,0,0,9,10a15,16,0,0,0,13,14V17v18H19h20C21,22 23,24 25,26c27,28 29,30 31,32Q33,34 35,36q37,38 39,40S41,42 43,44s45,46 47,48T49,50t51,52z")
  end
end