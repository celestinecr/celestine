# Finds all available `*_attribute` methods inside a drawable and calls with an `IO`
macro draw_attributes(io)
  {% for method in ([@type] + @type.ancestors).map(&.methods.map(&.name)).reduce{|sum, i| sum + i }.select {|m| m.ends_with?("_attribute")} %}
  {{method}}({{io.id}})
  {% end %}
end