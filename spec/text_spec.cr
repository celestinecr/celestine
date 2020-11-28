describe Celestine::Text do
  make_number_attribute_test(Celestine::Text, "dx", units: true)
  make_number_attribute_test(Celestine::Text, "dy", units: true)
  make_number_attribute_test(Celestine::Text, "textLength", "length", units: true)
  make_number_attribute_test(Celestine::Text, "lengthAdjust", "length_adjust", units: true)
end