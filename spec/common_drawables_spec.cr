{% for drawable_class in Celestine::Meta::CLASSES %}
describe {{drawable_class.id}} do
  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::CPosition } %}

  make_number_attribute_test({{drawable_class.id}}, "cx", "x")
  make_number_attribute_test({{drawable_class.id}}, "cy", "y")

  {% elsif drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Position } %}

  make_number_attribute_test({{drawable_class.id}}, "x", "x")
  make_number_attribute_test({{drawable_class.id}}, "y", "y")

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Body } %}

  make_number_attribute_test({{drawable_class.id}}, "width", "width")
  make_number_attribute_test({{drawable_class.id}}, "height", "height")

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::StrokeFill } %}

  make_color_attribute_test({{drawable_class.id}}, "stroke", "stroke")
  make_color_attribute_test({{drawable_class.id}}, "fill", "fill")

  {% end %}
end
{% end %}

#   it "rectangle should set attribute width" do
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.width = 100; r} } =~ /width\=\"100\"/)).should eq(true)
#   end

#   it "rectangle should set attribute height" do
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.height = 100; r} } =~ /height\=\"100\"/)).should eq(true)
#   end

#   it "rectangle should set attribute fill" do
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "black"; r} } =~ /fill\=\"black\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "red"; r} } =~ /fill\=\"red\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "#121212"; r} } =~ /fill\=\"\#121212\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.fill = "#AAAAAA"; r} } =~ /fill\=\"\#AAAAAA\"/)).should eq(true)
#   end

#   it "rectangle should set attribute stroke" do
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "black"; r} } =~ /stroke\=\"black\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "red"; r} } =~ /stroke\=\"red\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "#121212"; r} } =~ /stroke\=\"\#121212\"/)).should eq(true)
#     (!!(Celestine.draw { |ctx| ctx.rectangle {|r| r.stroke = "#AAAAAA"; r} } =~ /stroke\=\"\#AAAAAA\"/)).should eq(true)
#   end
# end
