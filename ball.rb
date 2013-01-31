class Ball
  attr_accessor :x, :y, :texture, :color

  DATA_PATH = File.join(File.dirname(__FILE__), "data/")
  TEXTURE_EXT = ".txt"

  def initialize(x, y)
    @x, @y = x, y
    @texture = File.read(DATA_PATH + "ball" + TEXTURE_EXT).split("\n")
    @color = Curses::COLOR_GREEN
  end

  def right_edge
    @x + @texture.first.length
  end

  def left_edge
    @x
  end

  def move_left
    self.x -= 1
  end

  def move_right
    self.x += 1
  end

  def move_down(how_much = 1)
    self.y -= how_much
  end
end