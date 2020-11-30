abstract class Celestine::Filter::Basic < Celestine::Drawable
  TAG = "WARNING CELESTINE::FILTER::BASIC NOT TO BE USED!!!!!"
  include_options Celestine::Modules::Body
  include Celestine::Modules::Animate

  property result : String?
end