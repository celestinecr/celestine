macro make_units(field)
  property {{field.id}} : IFNumber? = nil

  # What kind of unit `{{field.id}}` should use when rendering
  property {{field.id}}_units : String? = nil
end

macro make_field(field)
  property {{field.id}} : IFNumber? = nil
end