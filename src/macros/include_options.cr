# Includes a module ands also includes it's ATTRS to the including class as well.
macro include_options(module_class)
  include {{module_class.id}}
  module Attrs
    include {{module_class.id}}::Attrs
  end

end