require "./spec_helper"

describe Celestine::Ellipse do
  make_number_attribute_test(Celestine::Ellipse, "rx", "radius_x", units: true)
  make_number_attribute_test(Celestine::Ellipse, "ry", "radius_y", units: true)
end