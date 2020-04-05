struct Celestine::Animate
  property attribute : String?  = nil
  property repeat_count : SIFNumber? = nil
  property duration : SIFNumber? = nil
  property values = [] of SIFNumber
  property from : SIFNumber? = nil
  property to : SIFNumber? = nil
  property by : SIFNumber? = nil

  property key_times = [] of SIFNumber
  property key_splines = [] of SIFNumber

  property min : SIFNumber? = nil
  property max : SIFNumber? = nil

  property repeat_duration : SIFNumber? = nil

  property? accumulate = false
  property? additive = false

  property? freeze = false
end