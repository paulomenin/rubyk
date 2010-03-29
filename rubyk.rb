require 'cube'
require 'cubescene'

class Rubyk
	def initialize
		@app_running = true
		@cube = Cube.new
		@scene = CubeScene.new(self, @cube)
	end

	def run
		while @app_running
			@scene.parse_events
			@scene.draw
		end
	end

	def quit_app
		@app_running = false
	end
end

rubyk = Rubyk.new
rubyk.run
