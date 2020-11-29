class Celestine::Filter::SpecularLighting < Celestine::Filter::Basic
  TAG = "feSpecularLighting"
  POINT_NODE_TAG = "fePointLight"
  SPOT_NODE_TAG = "feSpotLight"
  DISTANT_NODE_TAG = "feDistantLight"

  property input : String?
  property lighting_color : String?
  property surface_scale : IFNumber?
  property constant : IFNumber?
  property exponent : IFNumber?
  property kernel_unit_length : IFNumber?


  # TODO: THESE CAN BE ANIMATABLE, NEED TO FIX LATER!!! MAKE LIKE MASK GROUP OR MARKER
  def add_point_light(x, y, z)
    inner_elements << %Q[<#{POINT_NODE_TAG} x="#{x}" y="#{y}" z="#{z}" />]
  end

  # TODO: THESE CAN BE ANIMATABLE, NEED TO FIX LATER!!! MAKE LIKE MASK GROUP OR MARKER
  def add_spot_light(x = nil, y = nil, z = nil, points_at_x = nil, points_at_y = nil, points_at_z = nil, specular_exponent = nil, limiting_cone_angle = nil)
    inner_elements << %Q[<#{SPOT_NODE_TAG} ]
    inner_elements << %Q[x="#{x}" ] if x
    inner_elements << %Q[y="#{y}" ] if y
    inner_elements << %Q[z="#{z}" ] if z
    inner_elements << %Q[pointsAtX="#{points_at_x}" ] if points_at_x
    inner_elements << %Q[pointsAtY="#{points_at_y}" ] if points_at_y
    inner_elements << %Q[pointsAtZ="#{points_at_z}" ] if points_at_z
    inner_elements << %Q[specularExponent="#{specular_exponent}" ] if specular_exponent
    inner_elements << %Q[limitingConeAngle="#{limiting_cone_angle}" ] if limiting_cone_angle
    inner_elements << "/>"
  end

  # TODO: THESE CAN BE ANIMATABLE, NEED TO FIX LATER!!! MAKE LIKE MASK GROUP OR MARKER
  def add_distant_light(azimuth, elevation)
    inner_elements << %Q[<#{DISTANT_NODE_TAG} azimuth="#{azimuth}" elevation="#{elevation}" />]
  end

  def draw(io : IO) : Nil
    io << %Q[<#{TAG} ]
    class_attribute(io)
    id_attribute(io)
    custom_attribute(io)
    transform_attribute(io)
    body_attribute(io)

    io << %Q[result="#{result}" ] if result

    io << %Q[input="#{input}" ] if input
    io << %Q[lighting-color="#{lighting_color}" ] if lighting_color
    io << %Q[surfaceScale="#{surface_scale}" ] if surface_scale
    io << %Q[specularConstant="#{constant}" ] if constant
    io << %Q[specularExponent="#{exponent}" ] if exponent
    io << %Q[kernelUnitLength="#{kernel_unit_length}" ] if kernel_unit_length

    if inner_elements.empty?
      io << %Q[/>]
    else
      io << ">"
      io << inner_elements
      io << "</#{TAG}>"
    end
  end

  module Attrs
  end
end