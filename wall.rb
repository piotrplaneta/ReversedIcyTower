class Wall
  attr_accessor :x, :y, :texture, :space_start

  def initialize(width, space_width, x, y)
    @width, @space_width, @x, @y = width, space_width, x, y
    @space_start = rand(0..(width - space_width))

    generate_texture
  end

  def generate_texture
    texture = '#' * @width

    texture[@space_start, @space_width] = " " * @space_width

    @texture = [texture]
  end

  def move_up
    self.y -= 1
  end
end