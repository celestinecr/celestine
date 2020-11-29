abstract class Celestine::Filter::Basic < Celestine::Drawable
  TAG = "WARNING CELESTINE::FILTER::BASIC NOT TO BE USED!!!!!"
  include_options Celestine::Modules::Body
  include Celestine::Modules::Animate
  include_options Celestine::Modules::Transform

  property result : String?
end