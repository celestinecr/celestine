# Gives drawables access to applied filters
module Celestine::Modules::Filter
  # The id of the filter to use on this drawable
  @filter_id : String? = nil

  # Sets the filter to use via ID for this drawable
  def set_filter(id : String)
    @filter_id = id
  end

  # Sets the filter to use for this drawable
  def set_filter(filter : Celestine::Filter)
    set_filter(filter.id.to_s)
  end

  # Draws the filter attribute to an `IO`
  def filter_attribute(io : IO)
    if @filter_id
      io << %Q[filter="url('##{@filter_id}')" ]
    end
  end

  module Attrs
    FILTER = "filter"
  end
end