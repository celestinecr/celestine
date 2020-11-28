{% for drawable_class in Celestine::Meta::CLASSES %}
describe {{drawable_class.id}} do
  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::CPosition } %}

  make_number_attribute_test({{drawable_class.id}}, "cx", "x", units: true)
  make_number_attribute_test({{drawable_class.id}}, "cy", "y", units: true)

  {% elsif drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Position } %}

  make_number_attribute_test({{drawable_class.id}}, "x", units: true)
  make_number_attribute_test({{drawable_class.id}}, "y", units: true)

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::Body } %}

  make_number_attribute_test({{drawable_class.id}}, "width", units: true)
  make_number_attribute_test({{drawable_class.id}}, "height", units: true)

  {% end %}


  {% if drawable_class.resolve.ancestors.any? { |a| a == Celestine::Modules::StrokeFill } %}

  make_color_attribute_test({{drawable_class.id}}, "stroke")
  make_color_attribute_test({{drawable_class.id}}, "fill")
  make_number_attribute_test({{drawable_class.id}}, "stroke-width", "stroke_width", units: true)
  make_number_attribute_test({{drawable_class.id}}, "fill-opacity", "fill_opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "stroke-opacity", "stroke_opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "opacity", units: false)
  make_number_attribute_test({{drawable_class.id}}, "stroke-dashoffset", "dash_offset", units: true)
  make_number_attribute_test({{drawable_class.id}}, "stroke-miterlimit", "miter_limit", units: true)


  {% end %}
end
{% end %}