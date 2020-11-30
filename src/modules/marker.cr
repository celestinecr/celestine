# Gives drawables access to the marker attributes
# TODO: Test this
module Celestine::Modules::Marker
  @marker_start_id : String? = nil
  @marker_mid_id : String? = nil
  @marker_end_id : String? = nil

  def set_marker_start(id : String)
    @marker_start_id = id
  end

  def set_marker_mid(id : String)
    @marker_mid_id = id
  end

  def set_marker_end(id : String)
    @marker_end_id = id
  end

  def set_marker_start(marker : Celestine::Marker)
    set_marker_start(marker.id.to_s)
  end

  def set_marker_mid(marker : Celestine::Marker)
    set_marker_mid(marker.id.to_s)
  end

  def set_marker_end(marker : Celestine::Marker)
    set_marker_end(marker.id.to_s)
  end

  def marker_attribute(io : IO)
    
    io << %Q[marker-start="url('##{@marker_start_id}')" ] if @marker_start_id
    io << %Q[marker-mid="url('##{@marker_mid_id}')" ] if @marker_mid_id
    io << %Q[marker-end="url('##{@marker_end_id}')" ] if @marker_end_id

  end

  module Attrs
    START = "marker-start"
    MID = "marker-mid"
    END = "marker-end"
  end
end