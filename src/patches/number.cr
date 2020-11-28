# struct Number
#   macro make_unit(unit_name)
#     def {{unit_name.id}}
#       "#{self.to_s}#{{{unit_name}}}"
#     end
#   end

#   # Can be used in SVG width height
#   make_unit "em"
#   make_unit "ex"
#   make_unit "px"
#   make_unit "in"
#   make_unit "cm"
#   make_unit "mm"
#   make_unit "pt"
#   make_unit "pc"
#   def percent
#     "#{self.to_s}%"
#   end

#   # Maybe can be used in <SVG> width height
#   make_unit "ch"
#   make_unit "rem"
#   make_unit "vw"
#   make_unit "vh"
#   make_unit "vmin"
#   make_unit "vmax"

#   #time units
#   make_unit "s"
#   make_unit "min"
#   make_unit "ms"
#   make_unit "h"
# end