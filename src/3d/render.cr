require "./triangle"
require "./mesh"


struct Celestine::Three::TestRender
  getter fov = 90.0

  property z_far = 1000.0
  property z_near = 0.1

  property width = 1000
  property height = 1000

  getter projection_matrix : VM::Mat4x4d = VM::Mat4x4d.identity

  def aspect_ratio : Float64
    height.to_f64/width.to_f64
  end

  def draw_mesh(mesh : Celestine::Three::Mesh)
    x_angle = rand() * 360.0
    z_angle = rand() * 360.0


    projection_matrix = VM::Mat4x4d.perspective_projection(fov, aspect_ratio, z_near, z_far)
   
    z_rot = VM::Mat4x4d.zero
    z_rot[0, 0] = ::Math.cos(z_angle)
    z_rot[0, 1] = ::Math.sin(z_angle)
    z_rot[1, 0] = -::Math.sin(z_angle)
    z_rot[1, 1] = ::Math.cos(z_angle)
    z_rot[2, 2] = 1
    z_rot[3, 3] = 1

    x_rot = VM::Mat4x4d.zero
    x_rot[0, 0] = 1
    x_rot[1, 1] = ::Math.cos(x_angle * 0.5)
    x_rot[1, 2] = ::Math.sin(x_angle * 0.5)
    x_rot[2, 1] = -::Math.sin(x_angle * 0.5)
    x_rot[2, 2] = ::Math.cos(x_angle * 0.5)
    x_rot[3, 3] = 1

    output = Celestine::Group.new
    projected_triangles = [] of Celestine::Three::ProjectedTriangle
    mesh.triangles.each do |triangle|

      triangle.p1 = (z_rot * triangle.p1.to_vec4).to_vec3
      triangle.p2 = (z_rot * triangle.p2.to_vec4).to_vec3
      triangle.p3 = (z_rot * triangle.p3.to_vec4).to_vec3

      triangle.p1 = (x_rot * triangle.p1.to_vec4).to_vec3
      triangle.p2 = (x_rot * triangle.p2.to_vec4).to_vec3
      triangle.p3 = (x_rot * triangle.p3.to_vec4).to_vec3

      triangle.p1.z += 3.0
      triangle.p2.z += 3.0
      triangle.p3.z += 3.0

      p_triangle = Celestine::Three::ProjectedTriangle.new  
      p_triangle.color = triangle.color

      p_triangle.p1 = (projection_matrix * triangle.p1.to_vec4).to_vec2
      p_triangle.p2 = (projection_matrix * triangle.p2.to_vec4).to_vec2
      p_triangle.p3 = (projection_matrix * triangle.p3.to_vec4).to_vec2

      p_triangle.p1.x += 1.0
      p_triangle.p1.y += 1.0

      p_triangle.p2.x += 1.0
      p_triangle.p2.y += 1.0

      p_triangle.p3.x += 1.0
      p_triangle.p3.y += 1.0

      p_triangle.p1.x *= 0.5 * width
      p_triangle.p1.y *= 0.5 * height

      p_triangle.p2.x *= 0.5 * width
      p_triangle.p2.y *= 0.5 * height

      p_triangle.p3.x *= 0.5 * width
      p_triangle.p3.y *= 0.5 * height

      projected_triangles << p_triangle
    end
    projected_triangles.each do |triangle|
      output.path do |path|
        path.a_move(triangle.p1.x, triangle.p1.y)
        path.a_line(triangle.p2.x, triangle.p2.y)
        path.a_line(triangle.p3.x, triangle.p3.y)
        path.close

        path.stroke = "black"
        path.stroke_width = 2
        path.fill = "##{triangle.color.to_s(16).rjust(6, '0')}"
        path
      end
    end
    output
  end
end