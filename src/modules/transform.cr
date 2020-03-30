module Celestine::Modules::Transform
  getter transform_options : String = ""

  def transform(&block : Proc(Celestine::Drawable::Transform, Nil))
    meta = Celestine::Drawable::Transform.new
    yield meta

    if !meta.empty?
      @transform_options = %Q[transform="#{meta.to_s}"]
    else
      @transform_options = ""
    end
  end
end