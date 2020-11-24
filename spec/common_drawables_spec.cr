{% for drawable_class in Celestine::Meta::CLASSES %}
describe {{drawable_class.id}} do
  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::CPosition } %}

  make_number_attribute_test({{drawable_class.id}}, "cx", "x")
  make_number_attribute_test({{drawable_class.id}}, "cy", "y")

  {% elsif drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Position } %}

  make_number_attribute_test({{drawable_class.id}}, "x")
  make_number_attribute_test({{drawable_class.id}}, "y")

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Body } %}

  make_number_attribute_test({{drawable_class.id}}, "width")
  make_number_attribute_test({{drawable_class.id}}, "height")

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::StrokeFill } %}

  make_color_attribute_test({{drawable_class.id}}, "stroke")
  make_color_attribute_test({{drawable_class.id}}, "fill")

  {% end %}
end
{% end %}