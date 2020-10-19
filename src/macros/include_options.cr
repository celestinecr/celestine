macro include_options(module_class)
  # Includes a module ands also includes it's ATTRS to the including class as well.
  include {{module_class.id}}
  module Attrs
    include {{module_class.id}}::Attrs
  end

end