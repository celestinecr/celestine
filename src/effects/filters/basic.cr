abstract class Celestine::Filter::Basic < Celestine::Drawable
  TAG = "WARNING CELESTINE::FILTER::BASIC NOT TO BE USED!!!!!"
  include_options Celestine::Modules::Body
  include Celestine::Modules::Animate

  property result : String?

  module Attrs
    RESULT = "result"
  end

  def filter_basic_attribute(io)
    io << %Q[#{Attrs::RESULT}="#{result}" ] if result
  end

  macro inherited
    module Attrs
      include Celestine::Filter::Basic::Attrs
    end
  end
end
