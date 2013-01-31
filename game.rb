# encoding: utf-8
PATH = File.dirname(__FILE__)

require "bundler/setup"
require "gaminator"
require File.join(PATH, "ball.rb")

class BallGame

  def initialize(width, height)
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
      ?d => :move_ball_right
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


  private

  def move_ball_left
    @ball.move_left
  end

  def move_ball_right
    @ball.move_right
  end

  def increase_tick_count
    @ticks += 1
  end


end


Gaminator::Runner.new(BallGame, :rows => 30, :cols => 80).run
