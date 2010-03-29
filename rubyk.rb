require 'cube'
require 'sdl'
require 'opengl'

class Rubyk
	def initialize
		@app_running = true
		@cube = Cube.new

		@window_width = 480
		@window_height = 480

		@rot_x = 25;
		@rot_y = 25;
		@rot_z = 0;

		init_SDL
		init_GL
	end

	def init_SDL
		SDL.init(SDL::INIT_VIDEO)

		SDL::Key.enable_key_repeat(0.2,0.2)

		SDL::GL.set_attr(SDL::GL::RED_SIZE, 5)
		SDL::GL.set_attr(SDL::GL::GREEN_SIZE, 5)
		SDL::GL.set_attr(SDL::GL::BLUE_SIZE, 5)
		SDL::GL.set_attr(SDL::GL::DEPTH_SIZE, 16)
		SDL::GL.set_attr(SDL::GL::DOUBLEBUFFER, 1)

		info = SDL::Screen.info
		bpp = info.bpp

		flags = SDL::OPENGL

		SDL::Screen.open(@window_width, @window_height, bpp, flags)
	end

	def init_GL
		glClearColor(0, 0, 0, 0)
		glClearDepth(1.0)
		glDepthFunc(GL_LEQUAL)
		glEnable(GL_DEPTH_TEST)
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
		glShadeModel(GL_SMOOTH)

		#glViewport(0, 0, @window_width, @window_height)

		glMatrixMode(GL_PROJECTION)
		glLoadIdentity
		glOrtho(-8, 8, -8, 8, -8, 8)

		glMatrixMode(GL_MODELVIEW)
		glLoadIdentity
	end

	def run
		while @app_running
			parse_events
			draw
		end
	end

	def parse_events
		while event = SDL::Event2.poll
			case event
				when SDL::Event2::Quit
					@app_running = false
				when SDL::Event2::KeyDown
					case
						when event.sym == SDL::Key::ESCAPE
							@app_running = false
						when event.sym == SDL::Key::LEFT
							@rot_y -= 5
						when event.sym == SDL::Key::RIGHT
							@rot_y += 5
						when event.sym == SDL::Key::UP
							@rot_x -= 5
						when event.sym == SDL::Key::DOWN
							@rot_x += 5
						when event.sym == SDL::Key::R
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:red,:ccw)
							else
								@cube.face_rotate(:red,:cw)
							end
						when event.sym == SDL::Key::W
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:white,:ccw)
							else
								@cube.face_rotate(:white,:cw)
							end
						when event.sym == SDL::Key::G
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:green,:ccw)
							else
								@cube.face_rotate(:green,:cw)
							end
						when event.sym == SDL::Key::B
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:blue,:ccw)
							else
								@cube.face_rotate(:blue,:cw)
							end
						when event.sym == SDL::Key::O
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:orange,:ccw)
							else
								@cube.face_rotate(:orange,:cw)
							end
						when event.sym == SDL::Key::Y
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:yellow,:ccw)
							else
								@cube.face_rotate(:yellow,:cw)
							end
						when event.sym == SDL::Key::S
							unless event.mod & SDL::Key::MOD_CTRL == 0
								@cube.scamble
							end
					end
			end
		end
	end

	def draw
		glMatrixMode(GL_MODELVIEW)
		glLoadIdentity
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
		
		glRotatef(@rot_x, 1,0,0)
		glRotatef(@rot_y, 0,1,0)
		glRotatef(@rot_z, 0,0,1)

		# bottom layer
		glPushMatrix
		glTranslatef(-2.1, -2.1, 2.1)
		draw_cube(:BLF)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, -2.1, 0)
		draw_cube(:BLM)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, -2.1, -2.1)
		draw_cube(:BLB)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, -2.1, 2.1)
		draw_cube(:BMF)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, -2.1, 0)
		draw_cube(:BMM)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, -2.1, -2.1)
		draw_cube(:BMB)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, -2.1, 2.1)
		draw_cube(:BRF)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, -2.1, 0)
		draw_cube(:BRM)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, -2.1, -2.1)
		draw_cube(:BRB)
		glPopMatrix
		
		# middle layer
		glPushMatrix
		glTranslatef(-2.1, 0, 2.1)
		draw_cube(:MLF)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, 0, 0)
		draw_cube(:MLM)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, 0, -2.1)
		draw_cube(:MLB)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, 0, 2.1)
		draw_cube(:MMF)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, 0, -2.1)
		draw_cube(:MMB)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 0, 2.1)
		draw_cube(:MRF)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 0, 0)
		draw_cube(:MRM)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 0, -2.1)
		draw_cube(:MRB)
		glPopMatrix
		
		# top layer
		glPushMatrix
		glTranslatef(-2.1, 2.1, 2.1)
		draw_cube(:TLF)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, 2.1, 0)
		draw_cube(:TLM)
		glPopMatrix
		glPushMatrix
		glTranslatef(-2.1, 2.1, -2.1)
		draw_cube(:TLB)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, 2.1, 2.1)
		draw_cube(:TMF)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, 2.1, 0)
		draw_cube(:TMM)
		glPopMatrix
		glPushMatrix
		glTranslatef(0, 2.1, -2.1)
		draw_cube(:TMB)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 2.1, 2.1)
		draw_cube(:TRF)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 2.1, 0)
		draw_cube(:TRM)
		glPopMatrix
		glPushMatrix
		glTranslatef(2.1, 2.1, -2.1)
		draw_cube(:TRB)
		glPopMatrix

		SDL::GL.swap_buffers
	end

	def draw_cube(position)
		glBegin(GL_QUADS)
		
		# Top face
		decide_face_color(position, :top)
		glVertex3f( 1.0, 1.0,-1.0)
		glVertex3f(-1.0, 1.0,-1.0)
		glVertex3f(-1.0, 1.0, 1.0)
		glVertex3f( 1.0, 1.0, 1.0)

		# Bottom face
		decide_face_color(position, :bottom)
		glVertex3f( 1.0,-1.0, 1.0)
		glVertex3f(-1.0,-1.0, 1.0)
		glVertex3f(-1.0,-1.0,-1.0)
		glVertex3f( 1.0,-1.0,-1.0)

		# Front face
		decide_face_color(position, :front)
		glVertex3f( 1.0, 1.0, 1.0)
		glVertex3f(-1.0, 1.0, 1.0)
		glVertex3f(-1.0,-1.0, 1.0)
		glVertex3f( 1.0,-1.0, 1.0)

		# Back face
		decide_face_color(position, :back)
		glVertex3f( 1.0,-1.0,-1.0)
		glVertex3f(-1.0,-1.0,-1.0)
		glVertex3f(-1.0, 1.0,-1.0)
		glVertex3f( 1.0, 1.0,-1.0)

		# Left face
		decide_face_color(position, :left)
		glVertex3f(-1.0, 1.0, 1.0)
		glVertex3f(-1.0, 1.0,-1.0)
		glVertex3f(-1.0,-1.0,-1.0)
		glVertex3f(-1.0,-1.0, 1.0)

		# Right face
		decide_face_color(position, :right)
		glVertex3f( 1.0, 1.0,-1.0)
		glVertex3f( 1.0, 1.0, 1.0)
		glVertex3f( 1.0,-1.0, 1.0)
		glVertex3f( 1.0,-1.0,-1.0)

		glEnd
	end

	def decide_face_color(position, face)
		case
			# Top Layer
			when position == :TLB then
				case
					when face == :top    then pick_color(@cube.get_white_face[0])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[0])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[2])
				end
			when position == :TLM then
				case
					when face == :top    then pick_color(@cube.get_white_face[3])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[1])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :TLF then
				case
					when face == :top    then pick_color(@cube.get_white_face[6])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[2])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[0])
					when face == :back   then pick_color(:black)
				end
			when position == :TMB then
				case
					when face == :top    then pick_color(@cube.get_white_face[1])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[1])
				end
			when position == :TMM then
				case
					when face == :top    then pick_color(@cube.get_white_face[4])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :TMF then
				case
					when face == :top    then pick_color(@cube.get_white_face[7])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[1])
					when face == :back   then pick_color(:black)
				end
			when position == :TRB then
				case
					when face == :top    then pick_color(@cube.get_white_face[2])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[2])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[0])
				end
			when position == :TRM then
				case
					when face == :top    then pick_color(@cube.get_white_face[5])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[1])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :TRF then
				case
					when face == :top    then pick_color(@cube.get_white_face[8])
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[0])
					when face == :front  then pick_color(@cube.get_red_face[2])
					when face == :back   then pick_color(:black)
				end
			# Middle Layer
			when position == :MLB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[3])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[5])
				end
			when position == :MLM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[4])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :MLF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(@cube.get_green_face[5])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[3])
					when face == :back   then pick_color(:black)
				end
			when position == :MMB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[4])
				end
			when position == :MMM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :MMF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[4])
					when face == :back   then pick_color(:black)
				end
			when position == :MRB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[5])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[3])
				end
			when position == :MRM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[4])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :MRF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(:black)
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[3])
					when face == :front  then pick_color(@cube.get_red_face[5])
					when face == :back   then pick_color(:black)
				end
			# Bottom Layer
			when position == :BLB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[6])
					when face == :left   then pick_color(@cube.get_green_face[6])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[8])
				end
			when position == :BLM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[3])
					when face == :left   then pick_color(@cube.get_green_face[7])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :BLF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[0])
					when face == :left   then pick_color(@cube.get_green_face[8])
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[6])
					when face == :back   then pick_color(:black)
				end
			when position == :BMB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[7])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[7])
				end
			when position == :BMM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[4])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :BMF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[1])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(:black)
					when face == :front  then pick_color(@cube.get_red_face[7])
					when face == :back   then pick_color(:black)
				end
			when position == :BRB then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[8])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[8])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(@cube.get_orange_face[6])
				end
			when position == :BRM then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[5])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[7])
					when face == :front  then pick_color(:black)
					when face == :back   then pick_color(:black)
				end
			when position == :BRF then
				case
					when face == :top    then pick_color(:black)
					when face == :bottom then pick_color(@cube.get_yellow_face[2])
					when face == :left   then pick_color(:black)
					when face == :right  then pick_color(@cube.get_blue_face[6])
					when face == :front  then pick_color(@cube.get_red_face[8])
					when face == :back   then pick_color(:black)
				end
		end
	end

	def pick_color(color)
		case
			when color == :white  then glColor3f(1.0, 1.0, 1.0)
			when color == :red    then glColor3f(1.0, 0.0, 0.0)
			when color == :green  then glColor3f(0.0, 1.0, 0.0)
			when color == :blue   then glColor3f(0.0, 0.0, 1.0)
			when color == :orange then glColor3f(1.0, 0.5, 0.0)
			when color == :yellow then glColor3f(1.0, 1.0, 0.0)
			else glColor3f(0.0, 0.0, 0.0)
		end
	end

end

rubyk = Rubyk.new
rubyk.run
