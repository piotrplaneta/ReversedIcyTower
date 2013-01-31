require "bundler/setup"
require "gaminator"

class Wall
	attr_accessor :result

	def generate(w)
		@starter = rand(w-1) + 1
		@result = "" 

		0.upto(@starter.to_i) do |iter|
			@result << "#"
		end

		@result << "   "

		@starter.upto(w-3) do |iter|
			@result << "#"
		end
	end

	def p
		puts @result
	end
end

w = Wall.new
w.generate(28)
w.p