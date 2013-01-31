require "bundler/setup"
require "gaminator"

class Wall
	attr_accessor :x, :y, :texture, :space_start

	def initialize(width, space_width, x, y)
		@width, @space_width, @x, @y = width, space_width, x, y
		@space_start = rand(0..(width - space_width - 2))

		generate_texture
	end

	def generate_texture
		texture = ""

		0.upto(@space_start) do
			texture += "#"
		end

		0.upto(@space_width) do
			texture += " "
		end

		texture += "#" while texture.length < @width

		@texture = [texture]
	end

	def move_up
		self.y -= 1
	end
end