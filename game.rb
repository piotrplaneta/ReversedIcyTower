# encoding: utf-8

require "bundler/setup"
require "gaminator"
load "ball.rb"
load "wall.rb"

class BallGame

  def initialize(width, height)
    @width, @height = width, height
    @ticks = 0
    @speed = 0
    @ball = Ball.new(width/2, height/2)
    @hole_width = 30
    @walls_count = (height / 10).to_i
    generate_walls
  end

  def objects
    @walls + [@ball]
  end

  def input_map
    {
      ?a => :move_ball_left,
      ?d => :move_ball_right,
      ?q => :exit
    }
  end

  def tick
    increase_tick_count
    walls_up
    clean_up_walls
    add_wall_if_necessary
    place_ball
    check_end_game
  end

  def exit_message
    "Your score: " + @ticks.to_s
  end

  def textbox_content
    "Your score: " + @ticks.to_s
  end

  def wait?
    false
  end

  def sleep_time
    [0.1 - @speed * 0.01, 0.001].max
  end

  def exit
    Kernel.exit
  end

  def move_ball_left
    @ball.move_left if can_move(@ball, :left)
  end

  def move_ball_right
    @ball.move_right if can_move(@ball, :right)
  end

  private

  def check_end_game
    if @ball.upper_edge == 0
      exit
    end
  end

  def place_ball
    colliding_walls = @walls.select do |wall|
      !(wall.texture.first[@ball.left_edge] == " " &&
        wall.texture.first[@ball.right_edge] == " ") &&
        wall.y >= @ball.y
    end

    if colliding_walls.length > 0
      highest_colliding_wall = colliding_walls.min_by { |wall| wall.y }
      @ball.lower_edge = highest_colliding_wall.y - 1
    else
      @ball.lower_edge = @height - 1
    end

  end

  def add_wall_if_necessary
    @walls << Wall.new(@width, @hole_width, 0, @height - 1) if @walls.length < @walls_count
  end

  def clean_up_walls
    @walls.reject! {|wall| wall.y <= 0}
  end

  def walls_up
    @walls.each { |wall| wall.move_up }
  end

  def generate_walls
    @walls = []
    @walls_count.times do |i|
      @walls << Wall.new(@width, @hole_width, 0, (i+1) * (@height / @walls_count).to_i)
    end
  end

  def can_move(object, direction)
    if direction == :right
      object.right_edge + 1 <= @width
    elsif direction == :left
      object.left_edge - 1 >= 0
    end
  end

  def increase_tick_count
    @ticks += 1
    if(@ticks % 50 == 0)
      @speed += 1
      @hole_width = [@hole_width, 4].max
    end
  end

end


Gaminator::Runner.new(BallGame).run
