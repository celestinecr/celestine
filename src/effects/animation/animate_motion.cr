class Celestine::Animate::Motion < Celestine::Drawable
  TAG = "animateMotion"
  include_options Celestine::Modules::Animate

  property rotate = "none"
  property key_points = [] of Float64
  getter mpath = ""

  property repeat_count : IFNumber | String? = nil
  property duration : Float64? = nil
  # TODO: Check if incoming unit is s ms or h.
  property duration_units : String? = nil
  property values = [] of Float64
  property from : Float64? = nil
  property from_units : String? = nil
  property to : Float64? = nil
  property to_units : String? = nil
  property by : Float64? = nil
  property by_units : String? = nil

  property key_times = [] of Float64
  property key_splines = [] of Float64

  property min : Float64? = nil
  property min_units : String? = nil
  property max : Float64? = nil
  property max_units : String? = nil

  property repeat_duration : Float64? = nil

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
    io << %Q[<#{TAG} ]
    # Puncuate attributes with a space 
    draw_attributes(io)

    io << %Q[repeatCount="#{repeat_count}" ]         if repeat_count
    io << %Q[repeatDur="#{repeat_duration}" ]        if repeat_duration
    io << %Q[dur="#{duration}#{duration_units}" ]    if duration
    unless values.empty?
      io << %Q[values="]
      values.join(io, ";")
      io << %Q[" ] 
    end
    io << %Q[from="#{from}#{from_units}" ]                        if from
    io << %Q[to="#{to}#{to_units}" ]                           if to
    io << %Q[by="#{by}#{by_units}" ]                           if by

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
    
    io << %Q[min="#{min}#{min_units}" ]                         if min
    io << %Q[min="#{max}#{max_units}" ]                         if max
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
      io << "</#{TAG}>"
    end

  end
end