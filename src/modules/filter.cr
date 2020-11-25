module Celestine::Modules::Filter
  @filter_id : String? = nil

  def set_filter(id : String)
    @filter_id = id
  end

  def set_filter(filter : Celestine::Filter)
    set_filter(filter.id.to_s)
  end

  def filter_attribute(io : IO)
    if @filter_id
      io << %Q[filter="url('##{@filter_id}')" ]
    end
  end

  module Attrs
    FILTER = "filter"
  end
end