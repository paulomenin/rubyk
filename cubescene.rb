require 'sdl'
require 'opengl'

class CubeScene
	ROT_LEFT  = 0b0001
	ROT_RIGHT = 0b0010
	ROT_UP    = 0b0100
	ROT_DOWN  = 0b1000
	ROT_STILL = 0b0000

	def initialize(app, cube)
		@app = app
		@cube = cube

		@rot_x = 25
		@rot_y = 25
		@rot_z = 0
		@rot_step = 2
		@rot_delay = 0.01 # in seconds
		@rot_lasttime = Time.now
		@rot_direction = 0b0000

		@window_width = 480
		@window_height = 480

		init_SDL
		init_GL
	end

	def init_SDL
		SDL.init(SDL::INIT_VIDEO)

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

	def parse_events
		while event = SDL::Event2.poll
			case event
				when SDL::Event2::Quit
					@app.quit_app
				when SDL::Event2::KeyDown
					case event.sym
						# Cube rotation
						when SDL::Key::LEFT  then @rot_direction |= ROT_LEFT
						when SDL::Key::RIGHT then @rot_direction |= ROT_RIGHT
						when SDL::Key::UP    then @rot_direction |= ROT_UP
						when SDL::Key::DOWN  then @rot_direction |= ROT_DOWN
						# Cube turns
						when SDL::Key::R
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:red,:ccw)
							else
								@cube.face_rotate(:red,:cw)
							end
						when SDL::Key::W
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:white,:ccw)
							else
								@cube.face_rotate(:white,:cw)
							end
						when SDL::Key::G
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:green,:ccw)
							else
								@cube.face_rotate(:green,:cw)
							end
						when SDL::Key::B
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:blue,:ccw)
							else
								@cube.face_rotate(:blue,:cw)
							end
						when SDL::Key::O
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:orange,:ccw)
							else
								@cube.face_rotate(:orange,:cw)
							end
						when SDL::Key::Y
							if event.mod & SDL::Key::MOD_SHIFT == 0
								@cube.face_rotate(:yellow,:ccw)
							else
								@cube.face_rotate(:yellow,:cw)
							end
						when SDL::Key::S
							@cube.scamble unless event.mod & SDL::Key::MOD_CTRL == 0
					end
				when SDL::Event2::KeyUp
					case event.sym
						when SDL::Key::ESCAPE then @app.quit_app
						# Cube rotation
						when SDL::Key::LEFT  then @rot_direction &= ~ROT_LEFT
						when SDL::Key::RIGHT then @rot_direction &= ~ROT_RIGHT
						when SDL::Key::UP    then @rot_direction &= ~ROT_UP
						when SDL::Key::DOWN  then @rot_direction &= ~ROT_DOWN
					end
			end
		end
	end

	def logic
		tick = Time.now
		# cube rotation
		unless @rot_direction == ROT_STILL
			if tick - @rot_lasttime >= @rot_delay
				@rot_lasttime = tick
				@rot_y += @rot_step if @rot_direction & ROT_LEFT == ROT_LEFT
				@rot_y -= @rot_step if @rot_direction & ROT_RIGHT == ROT_RIGHT
				@rot_x += @rot_step if @rot_direction & ROT_UP == ROT_UP
				@rot_x -= @rot_step if @rot_direction & ROT_DOWN == ROT_DOWN
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
		case position
			# Top Layer
			when :TLB
				case face
					when :top    then pick_color(@cube.get_white_face[0])
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[0])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[2])
				end
			when :TLM
				case face
					when :top    then pick_color(@cube.get_white_face[3])
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[1])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :TLF
				case face
					when :top    then pick_color(@cube.get_white_face[6])
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[2])
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[0])
					when :back   then pick_color(:black)
				end
			when :TMB
				case face
					when :top    then pick_color(@cube.get_white_face[1])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[1])
				end
			when :TMM
				case face
					when :top    then pick_color(@cube.get_white_face[4])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :TMF
				case face
					when :top    then pick_color(@cube.get_white_face[7])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[1])
					when :back   then pick_color(:black)
				end
			when :TRB
				case face
					when :top    then pick_color(@cube.get_white_face[2])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[2])
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[0])
				end
			when :TRM
				case face
					when :top    then pick_color(@cube.get_white_face[5])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[1])
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :TRF
				case face
					when :top    then pick_color(@cube.get_white_face[8])
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[0])
					when :front  then pick_color(@cube.get_red_face[2])
					when :back   then pick_color(:black)
				end
			# Middle Layer
			when :MLB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[3])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[5])
				end
			when :MLM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[4])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :MLF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(@cube.get_green_face[5])
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[3])
					when :back   then pick_color(:black)
				end
			when :MMB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[4])
				end
			when :MMM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :MMF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[4])
					when :back   then pick_color(:black)
				end
			when :MRB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[5])
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[3])
				end
			when :MRM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[4])
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :MRF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(:black)
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[3])
					when :front  then pick_color(@cube.get_red_face[5])
					when :back   then pick_color(:black)
				end
			# Bottom Layer
			when :BLB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[6])
					when :left   then pick_color(@cube.get_green_face[6])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[8])
				end
			when :BLM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[3])
					when :left   then pick_color(@cube.get_green_face[7])
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :BLF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[0])
					when :left   then pick_color(@cube.get_green_face[8])
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[6])
					when :back   then pick_color(:black)
				end
			when :BMB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[7])
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[7])
				end
			when :BMM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[4])
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :BMF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[1])
					when :left   then pick_color(:black)
					when :right  then pick_color(:black)
					when :front  then pick_color(@cube.get_red_face[7])
					when :back   then pick_color(:black)
				end
			when :BRB
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[8])
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[8])
					when :front  then pick_color(:black)
					when :back   then pick_color(@cube.get_orange_face[6])
				end
			when :BRM
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[5])
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[7])
					when :front  then pick_color(:black)
					when :back   then pick_color(:black)
				end
			when :BRF
				case face
					when :top    then pick_color(:black)
					when :bottom then pick_color(@cube.get_yellow_face[2])
					when :left   then pick_color(:black)
					when :right  then pick_color(@cube.get_blue_face[6])
					when :front  then pick_color(@cube.get_red_face[8])
					when :back   then pick_color(:black)
				end
		end
	end

	def pick_color(color)
		case color
			when :white  then glColor3f(1.0, 1.0, 1.0)
			when :red    then glColor3f(1.0, 0.0, 0.0)
			when :green  then glColor3f(0.0, 1.0, 0.0)
			when :blue   then glColor3f(0.0, 0.0, 1.0)
			when :orange then glColor3f(1.0, 0.5, 0.0)
			when :yellow then glColor3f(1.0, 1.0, 0.0)
			else glColor3f(0.0, 0.0, 0.0)
		end
	end

end
