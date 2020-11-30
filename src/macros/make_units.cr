# Makes 2 properties. One for the actual field, and one for the units the field is in.
macro make_units(field)
  property {{field.id}} : IFNumber? = nil

  # What kind of unit `{{field.id}}` should use when rendering
  property {{field.id}}_units : String? = nil
end