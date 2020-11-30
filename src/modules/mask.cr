# Gives drawable access to an applied mask
module Celestine::Modules::Mask
  # The mask to use on this drawable
  @mask_id : String? = nil

  # Sets the mask to use via ID on this drawable
  def set_mask(id : String)
    @mask_id = id
  end

  # Sets the mask to use on this drawable
  def set_mask(mask : Celestine::Mask)
    set_mask(mask.id.to_s)
  end

  # Draws the mask atttribute out to an `IO`
  def mask_attribute(io : IO)
    if @mask_id
      io << %Q[mask="url('##{@mask_id}')" ]
    end
  end

  module Attrs
    MASK = "mask"
  end
end