$LOAD_PATH << File.expand_path('./lib')

require "bundler/setup"
require "gaminator"
require "ball_game"

Gaminator::Runner.new(BallGame).run