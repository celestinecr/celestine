require "./triangle"
require "./mesh"


struct Celestine::Three::TestRender
  getter fov : Float32 = 90.0f32

  property z_far = 1000.0f32
  property z_near = 0.1f32

  property width = 1000
  property height = 1000

  def aspect_ratio
    height.to_f32/width.to_f32
  end

  def draw_mesh(mesh : Celestine::Three::Mesh)
    projection_matrix = VM::Mat4x4f.perspective_projection(fov, aspect_ratio, z_near, z_far)
    output = Celestine::Group.new
    projected_trianges = [] of Celestine::Three::ProjectedTriangle
    mesh.triangles.each do |triangle|
      triangle.p1.z += 3.0f32
      triangle.p2.z += 3.0f32
      triangle.p3.z += 3.0f32

      p_triangle = Celestine::Three::ProjectedTriangle.new
      
      p_triangle.p1 = triangle.p1 * @projection_matrix
      p_triangle.p2 = triangle.p2 * @projection_matrix
      p_triangle.p3 = triangle.p3 * @projection_matrix

      p_triangle.p1.x += 1.0f32
      p_triangle.p1.y += 1.0f32

      p_triangle.p2.x += 1.0f32
      p_triangle.p2.y += 1.0f32

      p_triangle.p3.x += 1.0f32
      p_triangle.p3.y += 1.0f32

      p_triangle.p1.x *= 0.5f32 * width
      p_triangle.p1.y *= 0.5f32 * height

      p_triangle.p2.x *= 0.5f32 * width
      p_triangle.p2.y *= 0.5f32 * height

      p_triangle.p3.x *= 0.5f32 * width
      p_triangle.p3.y *= 0.5f32 * height

      projected_triangles << p_triangle
    end
    projected_triangles.each do |triangle|
      output.path do |path|
        path.a_move(triangle.p1.x, triangle.p1.y)
        path.a_live(triangle.p2.x, triangle.p2.y)
        path.a_live(triangle.p3.x, triangle.p3.y)
        path.close

        path.stroke = "black"
        path.fill = "none"
      end
    end
    output
  end
end