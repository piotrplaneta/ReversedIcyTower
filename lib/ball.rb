class Ball
  attr_accessor :x, :y, :texture, :color

  DATA_PATH = File.join(File.dirname(__FILE__), "../data/")
  TEXTURE_EXT = ".txt"

  def initialize(x, y)
    @x, @y = x, y
    @texture = File.read(DATA_PATH + "ball" + TEXTURE_EXT).split("\n")
    @color = Curses::COLOR_GREEN
  end

  def right_edge
    @x + @texture.first.length - 1
  end

  def left_edge
    @x
  end

  def lower_edge
    @y + texture.length - 1
  end

  def lower_edge=(value)
    @y = value - texture.length + 1
  end

  def upper_edge
    @y
  end

  def move_left
    self.x -= 3
  end

  def move_right
    self.x += 3
  end

  def move_up
    self.y -= 1
  end

  def move_down(how_much = 1)
    self.y -= how_much
  end

  def can_get_through(wall)
    wall.texture.first[left_edge] == " " &&
      wall.texture.first[right_edge] == " "
  end
end