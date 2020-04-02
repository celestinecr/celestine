module Celestine::Modules::Mask
  def mask_options(&block : Proc(Celestine::Mask, Nil))
    mask = Celestine::Mask.new
    yield animate
    if mask.id
    end
  end
end