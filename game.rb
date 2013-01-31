# encoding: utf-8
PATH = File.dirname(__FILE__)

require "bundler/setup"
require "gaminator"
require File.join(PATH, "ball.rb")

class BallGame

  def initialize(width, height)
    @width, @height = width, height
    @ticks = 0
    @speed = 0
    @ball = Ball.new(1, 1)
  end

  def objects
    [@ball]
  end

  def input_map
    {
      ?a => :move_ball_left,
      ?d => :move_ball_right,
    }
  end

  def tick
    increase_tick_count
  end

  def exit_message
  end

  def textbox_content
  end

  def wait?
    false
  end

  def sleep_time
    0.05 - @speed * 0.05
  end

  def move_ball_left
    @ball.move_left if can_move(@ball, :left)
  end

  def move_ball_right
    @ball.move_right if can_move(@ball, :right)
  end

  private

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
