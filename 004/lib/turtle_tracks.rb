# require 'matrix'

module TurtleTracks
  def self.run(input_file)
    commands = []
    grid_size = 0
    @grid_output = ''
    @pos_x = 0
    @pos_y = 0
    angle = 0
    @change_to_x = []


    File.open(input_file, 'r').each_line do |line|
      temp = line.split(' ')
      if temp.length == 1
        grid_size = temp[0].to_i
      elsif temp[0] == 'REPEAT'
        (1..temp[1].to_i).each do
          temp[3..-2].each_slice(2) do |a|
            my_string = a[0] + ' ' + a[1] + "\n"
            commands << my_string
          end
        end
      elsif temp.length > 1
        commands << line
      end
    end

    starting_grid(grid_size)
    # @grid_output = Matrix.build(grid_size,grid_size) {0}
    @pos_x = (grid_size / 2).ceil
    @pos_y = @pos_x

    # puts commands

    commands.each_with_index do |line,i|
      temp = line.chop.split(' ')
      angle += temp[1].to_i if temp[0] == 'RT'
      angle -= temp[1].to_i if temp[0] == 'LT'
      angle = angle - 360 if angle > 360
      if temp[0] == 'FD'
        move_forward(angle, temp[1].to_i)
      end
      # puts i.to_s + ' ' + temp[1] + ' ' + angle.to_s
    end

    # print commands
    # print @grid_output
    # print @change_to_x

    change_values(@change_to_x, grid_size)
  end

  def self.starting_grid(grid_size)
    start_row = (grid_size / 2).ceil
    (1..grid_size.to_i).each do |row|
      if row == start_row
        (1..grid_size).each do |i|
          if i == start_row.to_i
            @grid_output += 'X '
            @pos_x = i
            @pos_y = i
          else
            @grid_output += '. '
          end
        end
        @grid_output += "\r\n"
      else
        @grid_output += '. ' * grid_size + "\r\n"
      end
    end
  end
  
  def self.move_forward(angle, spaces)
    case angle
      when 0
        (1..spaces.to_i).each do
          @pos_y -= 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 45
        (1..spaces.to_i).each do
          @pos_y -= 1
          @pos_x += 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 90
        (1..spaces.to_i).each do
          @pos_x += 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 135
        (1..spaces.to_i).each do
          @pos_y += 1
          @pos_x += 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 180
        (1..spaces.to_i).each do
          @pos_y += 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 225
        (1..spaces.to_i).each do
          @pos_y += 1
          @pos_x -= 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 270
        (1..spaces.to_i).each do
          @pos_x -= 1
          @change_to_x << [@pos_x, @pos_y]
        end
      when 315
        (1..spaces.to_i).each do
          @pos_y -= 1
          @pos_x -= 1
          @change_to_x << [@pos_x, @pos_y]
        end
    end
  end

  def self.change_values(coords, grid_size)
    grid_array = @grid_output.split("\r\n")
    coords.each do |p|
      line = grid_array[p[1]-1].split(' ')
      line[p[0]] = "X"
      line = line.join(" ") + ' '
      grid_array[p[1]-1] = line

    end
    # print grid_array
    puts grid_array.join("\r\n")
  end
end
