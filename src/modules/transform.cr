module Celestine::Modules::Transform
  getter transform_options : String = ""

  def transform(&block : Celestine::Drawable::Transform -> Celestine::Drawable::Transform)
    meta = yield Celestine::Drawable::Transform.new

    if !meta.empty?
      @transform_options = %Q[transform="#{meta.to_s}"]
    else
      @transform_options = ""
    end
  end

  module Attrs
    TRANSFORM = "transform"
  end
end