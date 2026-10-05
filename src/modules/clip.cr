# Gives drawable access to an applied clip-path
module Celestine::Modules::Clip
  # The clip-path ID to use on this drawable
  @clip_path_id : String? = nil

  # The clip-rule to use on this drawable (nonzero | evenodd | inherit)
  @clip_rule : String? = nil

  # Sets the clip-path to use via ID on this drawable
  def set_clip_path(id : String)
    @clip_path_id = id
  end

  # Sets the clip-path to use on this drawable
  def set_clip_path(clip_path : Celestine::ClipPath)
    set_clip_path(clip_path.id.to_s)
  end

  # Sets the clip-rule attribute
  def clip_rule=(val : String)
    @clip_rule = val
  end

  # Gets the clip-rule attribute
  def clip_rule : String?
    @clip_rule
  end

  # Draws the clip-path and clip-rule attributes to an `IO`
  def clip_path_attribute(io : IO)
    if id = @clip_path_id
      io << %Q[clip-path="url('##{id}')" ]
    end
    if rule = @clip_rule
      io << %Q[clip-rule="#{rule}" ]
    end
  end

  module Attrs
    CLIP_PATH = "clip-path"
    CLIP_RULE = "clip-rule"
  end
end
