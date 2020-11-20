struct Celestine::Animate::Motion < Celestine::Drawable
  include_options Celestine::Modules::Animate

  property rotate = "none"
  property key_points = [] of SIFNumber
  getter mpath = ""

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

  def mpath(&block : Proc(Celestine::Path, Nil))
    path = yield Celestine::Path.new
    @mpath = path.code
  end

  def mpath=(path : Celestine::Path)
    @mpath = path.code
  end

  def link_mpath(path : Celestine::Path)
    if path.id
      @mpath = "##{path.id}"
    else
      raise "You must give an ID with elements you want to reuse"
    end
  end

  def link_mpath(id : String)
    @mpath = id
  end

  def draw(io : IO) : Nil
    io << %Q[<animateMotion ]
    # Puncuate attributes with a space 
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    io << %Q[repeatCount="#{repeat_count}" ]         if repeat_count
    io << %Q[repeatDur="#{repeat_duration}" ]        if repeat_duration
    io << %Q[dur="#{duration}" ]                     if duration
    unless values.empty?
      io << %Q[values="]
      values.join(io, ";")
      io << %Q[" ] 
    end
    io << %Q[from="#{from}"]                        if from
    io << %Q[to="#{to}" ]                           if to
    io << %Q[by="#{by}" ]                           if by

    unless key_times.empty?
      io << %Q[keyTimes="]
      key_times.join(io, ";")
      io << %Q[" ] 
    end

    unless key_splines.empty?
      io << %Q[keySplines="]
      key_splines.join(io, ";")
      io << %Q[" ] 
    end
    
    io << %Q[min="#{min}" ]                         if min
    io << %Q[min="#{max}" ]                         if max
    io << %Q[accumulate="sum" ]                              if accumulate?
    io << %Q[additive="sum" ]                                if additive?
    io << %Q[fill="freeze" ]                                 if freeze?

    if mpath =~ /^#/
      inner_elements << %Q[<mpath xlink:href="#{mpath}"/>]
    else
      io << %Q[path="#{mpath}" ] 
    end

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</animateMotion>"
    end

  end
end