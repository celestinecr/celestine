module Celestine::Modules::Mask
  @mask_id : String? = nil
  def set_mask(id : String)
    @mask_id = id
  end

  def set_mask(mask : Celestine::Mask)
    set_mask(mask.id.to_s)
  end

  def mask_options
    if @mask_id
      %Q[mask="url('##{@mask_id}')"]
    else
      ""
    end
  end

  module Attrs
    MASK = "mask"
  end
end