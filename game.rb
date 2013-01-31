# encoding: utf-8
PATH = File.dirname(__FILE__)

require "bundler/setup"
require "gaminator"
require File.join(PATH, "ball.rb")
require File.join(PATH, "wall.rb")

class BallGame

  def initialize(width, height)
    @width, @height = width, height
    @ticks = 0
    @speed = 0
    @ball = Ball.new(width/2, height/2)
    generate_walls
  end

  def objects
    @walls + [@ball]
  end

  def input_map
    {
      ?a => :move_ball_left,
      ?d => :move_ball_right,
    }
  end

  def tick
    increase_tick_count
    walls_up
    clean_up_walls
    add_wall_if_necessary
    ball_up_if_above_a_wall
    check_end_game
  end

  def exit_message
    "Twój wynik: " + @ticks.to_s
  end

  def textbox_content
    "Twój wynik: " + @ticks.to_s
  end

  def wait?
    false
  end

  def sleep_time
    0.1
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

  def ball_up_if_above_a_wall
    @walls.each do |wall|
      if wall.y + 1 == @ball.lower_edge
        unless wall.texture.first[@ball.left_edge] == " " && wall.texture.first[@ball.right_edge] == " "
          @ball.move_up
        end
      end
    end
  end

  def add_wall_if_necessary
    @walls << Wall.new(78, 30, 0, 20) if @walls.length < 3
  end

  def clean_up_walls
    @walls.reject! {|wall| wall.y == 0}
  end

  def walls_up
    @walls.each { |wall| wall.move_up }
  end

  def generate_walls
    @walls = []
    3.times do |i|
      @walls << Wall.new(78, 30, 0, i * 10)
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
  end

end


Gaminator::Runner.new(BallGame, :rows => 30, :cols => 80).run
