class Turtle
  attr_accessor :board, :angle, :size
  def initialize(size, board=nil)
    @size = size
    @angle = 0
    @board = board || ["."]*(size*size)
    @pos = (size * size - 1) / 2
    @board[@pos] = "X"
  end
  def ==(other)
    to_s == other.to_s
  end
  def to_s
    @board.each_slice(size).map { |row| row.join(" ") }.join("\n")
  end
  def right(ang)
    @angle += (360 - ang)
    @angle %= 360
    self
  end
  def left(ang)
    @angle += ang
    @angle %= 360
    self
  end
  def offset
    case angle
    when 0;   -size
    when 45;  -size - 1
    when 90;        - 1
    when 135; +size - 1
    when 180; +size
    when 225; +size + 1
    when 270;       + 1
    when 315; -size + 1
    end
  end
  def backward(steps)
    steps.times do
      @pos -= offset
      @board[@pos] = "X"
    end
    self
  end
  def forward(steps)
    steps.times do
      @pos += offset
      @board[@pos] = "X"
    end
    self
  end
  def command(str)
    cmds = str.scan(/\S+/)
    while !cmds.empty?
      cmd = cmds.shift
      arg = cmds.shift.to_i
      case cmd
      when "FD"; forward(arg)
      when "LT"; left(arg)
      when "RT"; right(arg)
      when "BK"; backward(arg)
      when "REPEAT"
        raise "[ expected" if cmds.shift != "["
        seq = ""
        while (cmd = cmds.shift) != "]"
          seq = seq + " #{cmd}"
        end
        raise "] expected" if cmd != "]"
        arg.times { command(seq) }
      else
        raise "Unknown command #{cmd.inspect}"
      end
    end
    self
  end
end
