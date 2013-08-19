class CanvasRenderer
  def render(canvas_size, points)
    canvas_grid = create_grid(canvas_size)
    fill_points(canvas_grid, points)
    convert_to_string(canvas_grid)
  end

private
  def create_grid(canvas_size)
    canvas_size.times.map do |y|
      canvas_size.times.map do |x|
        "."
      end
    end
  end

  def fill_points(canvas_grid, points)
    points.each do |point|
      canvas_grid[point.y][point.x] = "X"
    end
  end

  def convert_to_string(canvas_grid)
    canvas_grid.map{ |row| row.join(" ")}.reverse.join("\n")
  end
end
