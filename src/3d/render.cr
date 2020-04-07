require "./triangle"
require "./mesh"


struct Celestine::Three::TestRender
  getter fov = 90.0

  getter camera = VM::Vec3d.zero

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
    projected_triangles = [] of Celestine::Three::Triangle
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

      # line1 = triangle.p2 - triangle.p1
      # line2 = triangle.p3 - triangle.p1

      # normal = VM::Vec3d.zero
      # normal.x = line1.y * line2.z - line1.z * line2.y
      # normal.y = line1.z * line2.x - line1.x * line2.z
      # normal.z = line1.x * line2.y - line1.y * line2.x

      # dot = ::Math.sqrt(normal.dot(normal))
      # normal = VM::Vec3d.new(normal.x/dot, normal.y/dot, normal.z/dot)
      # normal_sum_v = VM::Vec3d.zero
      # normal_sum_v.x = normal.x * (triangle.p1.x - camera.x)
      # normal_sum_v.y = normal.y * (triangle.p1.y - camera.y)
      # normal_sum_v.z = normal.z * (triangle.p1.z - camera.z)

      # if (normal_sum_v.x + normal_sum_v.y + normal_sum_v.z) < 0.0
        p_triangle = Celestine::Three::Triangle.new  
        p_triangle.color = triangle.color

        p_triangle.p1 = (projection_matrix * triangle.p1.to_vec4).to_vec3
        p_triangle.p2 = (projection_matrix * triangle.p2.to_vec4).to_vec3
        p_triangle.p3 = (projection_matrix * triangle.p3.to_vec4).to_vec3

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
      # end
    end

    projected_triangles.sort! do |t1, t2|
      z1 = (t1.p1.z + t1.p2.z + t1.p3.z)/3.0
      z2 = (t2.p1.z + t2.p2.z + t2.p3.z)/3.0
      z1 <=> z2
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