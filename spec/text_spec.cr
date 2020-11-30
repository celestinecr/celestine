describe Celestine::Text do
  make_number_attribute_test(Celestine::Text, "dx", units: true)
  make_number_attribute_test(Celestine::Text, "dy", units: true)
  make_number_attribute_test(Celestine::Text, "textLength", "length", units: true)
  make_number_attribute_test(Celestine::Text, "font-size", "font_size", units: true)
  make_number_attribute_test(Celestine::Text, "letter-spacing", "letter_spacing", units: true)
end