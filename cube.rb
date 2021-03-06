
class Cube
	def initialize()
		@white_face = [:white,:white,:white,:white,:white,:white,:white,:white,:white]
		@red_face = [:red,:red,:red,:red,:red,:red,:red,:red,:red]
		@blue_face = [:blue,:blue,:blue,:blue,:blue,:blue,:blue,:blue,:blue]
		@orange_face = [:orange,:orange,:orange,:orange,:orange,:orange,:orange,:orange,:orange]
		@green_face = [:green,:green,:green,:green,:green,:green,:green,:green,:green]
		@yellow_face = [:yellow,:yellow,:yellow,:yellow,:yellow,:yellow,:yellow,:yellow,:yellow]

		@movement_history = []
		@current_pos = 0
	end

	def get_white_face
		@white_face
	end
	def get_red_face
		@red_face
	end
	def get_blue_face
		@blue_face
	end
	def get_orange_face
		@orange_face
	end
	def get_green_face
		@green_face
	end
	def get_yellow_face
		@yellow_face
	end

	def solved?()
		9.times do |i|
			unless @white_face[i] == :white
				return false
			end
		end
		9.times do |i|
			unless @red_face[i] == :red
				return false
			end
		end
		9.times do |i|
			unless @blue_face[i] == :blue
				return false
			end
		end
		9.times do |i|
			unless @orange_face[i] == :orange
				return false
			end
		end
		9.times do |i|
			unless @green_face[i] == :green
				return false
			end
		end
		9.times do |i|
			unless @yellow_face[i] == :yellow
				return false
			end
		end
		return true
	end

	def representation(color)
		rep = case color
			when :white  then 'W'
			when :blue   then 'B'
			when :orange then 'O'
			when :red    then 'R'
			when :green  then 'G'
			when :yellow then 'Y'
			else '-'
		end
	end

	def print_cube()
		print "[#{@current_pos}/#{@movement_history.length}] "
		@movement_history.length.times do |i|
			print ' >' if i == @current_pos-1
			print @movement_history[i]
			print '< ' if i == @current_pos-1
		end
		puts

		9.times do |i|
			if i%3 == 0
				7.times {print ' '}
			end
			print "#{representation(@white_face[i])} "
			if i%3 == 2
				puts ''
			end
		end

		3.times do |i|
			print "#{representation(@green_face[i])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@red_face[i])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@blue_face[i])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@orange_face[i])} "
		end
		puts ''
		
		3.times do |i|
			print "#{representation(@green_face[i+3])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@red_face[i+3])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@blue_face[i+3])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@orange_face[i+3])} "
		end
		puts ''
		
		3.times do |i|
			print "#{representation(@green_face[i+6])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@red_face[i+6])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@blue_face[i+6])} "
		end
		print ' '
		3.times do |i|
			print "#{representation(@orange_face[i+6])} "
		end
		puts ''

		9.times do |i|
			if i%3 == 0
				7.times {print ' '}
			end
			print "#{representation(@yellow_face[i])} "
			if i%3 == 2
				puts ''
			end
		end
	end

	def face_rotate(face, direction, save_history=true)
		return if @current_pos != @movement_history.length and save_history
		case face
			when :red then rotate_red(direction, save_history)
			when :white then rotate_white(direction, save_history)
			when :green then rotate_green(direction, save_history)
			when :blue then rotate_blue(direction, save_history)
			when :yellow then rotate_yellow(direction, save_history)
			when :orange then rotate_orange(direction, save_history)
		end
		@current_pos += 1 if save_history
	end

	def rotate_red(direction, save_history=true)
		if direction == :cw
			@movement_history.push('R') if save_history
			tmp = @white_face[6]
			@white_face[6] = @green_face[8]
			@green_face[8] = @yellow_face[2]
			@yellow_face[2] = @blue_face[0]
			@blue_face[0] = tmp
			
			tmp = @white_face[7]
			@white_face[7] = @green_face[5]
			@green_face[5] = @yellow_face[1]
			@yellow_face[1] = @blue_face[3]
			@blue_face[3] = tmp
			
			tmp = @white_face[8]
			@white_face[8] = @green_face[2]
			@green_face[2] = @yellow_face[0]
			@yellow_face[0] = @blue_face[6]
			@blue_face[6] = tmp
			
			tmp = @red_face[0]
			@red_face[0] = @red_face[6]
			@red_face[6] = @red_face[8]
			@red_face[8] = @red_face[2]
			@red_face[2] = tmp
			tmp = @red_face[1]
			@red_face[1] = @red_face[3]
			@red_face[3] = @red_face[7]
			@red_face[7] = @red_face[5]
			@red_face[5] = tmp
		else
			@movement_history.push('r') if save_history
			tmp = @white_face[6]
			@white_face[6] = @blue_face[0]
			@blue_face[0] = @yellow_face[2]
			@yellow_face[2] = @green_face[8]
			@green_face[8] = tmp
			
			tmp = @white_face[7]
			@white_face[7] = @blue_face[3]
			@blue_face[3] = @yellow_face[1]
			@yellow_face[1] = @green_face[5]
			@green_face[5] = tmp
			
			tmp = @white_face[8]
			@white_face[8] = @blue_face[6]
			@blue_face[6] = @yellow_face[0]
			@yellow_face[0] = @green_face[2]
			@green_face[2] = tmp
			
			tmp = @red_face[0]
			@red_face[0] = @red_face[2]
			@red_face[2] = @red_face[8]
			@red_face[8] = @red_face[6]
			@red_face[6] = tmp
			tmp = @red_face[1]
			@red_face[1] = @red_face[5]
			@red_face[5] = @red_face[7]
			@red_face[7] = @red_face[3]
			@red_face[3] = tmp
		end
	end

	def rotate_orange(direction, save_history=true)
		if direction == :cw
			@movement_history.push('O') if save_history
			tmp = @white_face[2]
			@white_face[2] = @blue_face[8]
			@blue_face[8] = @yellow_face[6]
			@yellow_face[6] = @green_face[0]
			@green_face[0] = tmp
			
			tmp = @white_face[1]
			@white_face[1] = @blue_face[5]
			@blue_face[5] = @yellow_face[7]
			@yellow_face[7] = @green_face[3]
			@green_face[3] = tmp
			
			tmp = @white_face[0]
			@white_face[0] = @blue_face[2]
			@blue_face[2] = @yellow_face[8]
			@yellow_face[8] = @green_face[6]
			@green_face[6] = tmp
			
			tmp = @orange_face[0]
			@orange_face[0] = @orange_face[6]
			@orange_face[6] = @orange_face[8]
			@orange_face[8] = @orange_face[2]
			@orange_face[2] = tmp
			tmp = @orange_face[1]
			@orange_face[1] = @orange_face[3]
			@orange_face[3] = @orange_face[7]
			@orange_face[7] = @orange_face[5]
			@orange_face[5] = tmp
		else
			@movement_history.push('o') if save_history
			tmp = @white_face[2]
			@white_face[2] = @green_face[0]
			@green_face[0] = @yellow_face[6]
			@yellow_face[6] = @blue_face[8]
			@blue_face[8] = tmp
			
			tmp = @white_face[1]
			@white_face[1] = @green_face[3]
			@green_face[3] = @yellow_face[7]
			@yellow_face[7] = @blue_face[5]
			@blue_face[5] = tmp
			
			tmp = @white_face[0]
			@white_face[0] = @green_face[6]
			@green_face[6] = @yellow_face[8]
			@yellow_face[8] = @blue_face[2]
			@blue_face[2] = tmp
			
			tmp = @orange_face[0]
			@orange_face[0] = @orange_face[2]
			@orange_face[2] = @orange_face[8]
			@orange_face[8] = @orange_face[6]
			@orange_face[6] = tmp
			tmp = @orange_face[1]
			@orange_face[1] = @orange_face[5]
			@orange_face[5] = @orange_face[7]
			@orange_face[7] = @orange_face[3]
			@orange_face[3] = tmp
		end
	end
	
	def rotate_yellow(direction, save_history=true)
		if direction == :cw
			@movement_history.push('Y') if save_history
			tmp = @red_face[6]
			@red_face[6] = @green_face[6]
			@green_face[6] = @orange_face[6]
			@orange_face[6] = @blue_face[6]
			@blue_face[6] = tmp

			tmp = @red_face[7]
			@red_face[7] = @green_face[7]
			@green_face[7] = @orange_face[7]
			@orange_face[7] = @blue_face[7]
			@blue_face[7] = tmp

			tmp = @red_face[8]
			@red_face[8] = @green_face[8]
			@green_face[8] = @orange_face[8]
			@orange_face[8] = @blue_face[8]
			@blue_face[8] = tmp
			
			tmp = @yellow_face[0]
			@yellow_face[0] = @yellow_face[6]
			@yellow_face[6] = @yellow_face[8]
			@yellow_face[8] = @yellow_face[2]
			@yellow_face[2] = tmp
			tmp = @yellow_face[1]
			@yellow_face[1] = @yellow_face[3]
			@yellow_face[3] = @yellow_face[7]
			@yellow_face[7] = @yellow_face[5]
			@yellow_face[5] = tmp
		else
			@movement_history.push('y') if save_history
			tmp = @red_face[6]
			@red_face[6] = @blue_face[6]
			@blue_face[6] = @orange_face[6]
			@orange_face[6] = @green_face[6]
			@green_face[6] = tmp

			tmp = @red_face[7]
			@red_face[7] = @blue_face[7]
			@blue_face[7] = @orange_face[7]
			@orange_face[7] = @green_face[7]
			@green_face[7] = tmp

			tmp = @red_face[8]
			@red_face[8] = @blue_face[8]
			@blue_face[8] = @orange_face[8]
			@orange_face[8] = @green_face[8]
			@green_face[8] = tmp
			
			tmp = @yellow_face[0]
			@yellow_face[0] = @yellow_face[2]
			@yellow_face[2] = @yellow_face[8]
			@yellow_face[8] = @yellow_face[6]
			@yellow_face[6] = tmp
			tmp = @yellow_face[1]
			@yellow_face[1] = @yellow_face[5]
			@yellow_face[5] = @yellow_face[7]
			@yellow_face[7] = @yellow_face[3]
			@yellow_face[3] = tmp
		end
	end

	def rotate_blue(direction, save_history=true)
		if direction == :cw
			@movement_history.push('B') if save_history
			tmp = @white_face[8]
			@white_face[8] = @red_face[8]
			@red_face[8] = @yellow_face[8]
			@yellow_face[8] = @orange_face[0]
			@orange_face[0] = tmp

			tmp = @white_face[5]
			@white_face[5] = @red_face[5]
			@red_face[5] = @yellow_face[5]
			@yellow_face[5] = @orange_face[3]
			@orange_face[3] = tmp

			tmp = @white_face[2]
			@white_face[2] = @red_face[2]
			@red_face[2] = @yellow_face[2]
			@yellow_face[2] = @orange_face[6]
			@orange_face[6] = tmp

			tmp = @blue_face[0]
			@blue_face[0] = @blue_face[6]
			@blue_face[6] = @blue_face[8]
			@blue_face[8] = @blue_face[2]
			@blue_face[2] = tmp
			tmp = @blue_face[1]
			@blue_face[1] = @blue_face[3]
			@blue_face[3] = @blue_face[7]
			@blue_face[7] = @blue_face[5]
			@blue_face[5] = tmp
		else
			@movement_history.push('b') if save_history
			tmp = @white_face[8]
			@white_face[8] = @orange_face[0]
			@orange_face[0] = @yellow_face[8]
			@yellow_face[8] = @red_face[8]
			@red_face[8] = tmp

			tmp = @white_face[5]
			@white_face[5] = @orange_face[3]
			@orange_face[3] = @yellow_face[5]
			@yellow_face[5] = @red_face[5]
			@red_face[5] = tmp

			tmp = @white_face[2]
			@white_face[2] = @orange_face[6]
			@orange_face[6] = @yellow_face[2]
			@yellow_face[2] = @red_face[2]
			@red_face[2] = tmp

			tmp = @blue_face[0]
			@blue_face[0] = @blue_face[2]
			@blue_face[2] = @blue_face[8]
			@blue_face[8] = @blue_face[6]
			@blue_face[6] = tmp
			tmp = @blue_face[1]
			@blue_face[1] = @blue_face[5]
			@blue_face[5] = @blue_face[7]
			@blue_face[7] = @blue_face[3]
			@blue_face[3] = tmp
		end
	end

	def rotate_green(direction, save_history=true)
		if direction == :cw
			@movement_history.push('G') if save_history
			tmp = @white_face[0]
			@white_face[0] = @orange_face[8]
			@orange_face[8] = @yellow_face[0]
			@yellow_face[0] = @red_face[0]
			@red_face[0] = tmp

			tmp = @white_face[3]
			@white_face[3] = @orange_face[5]
			@orange_face[5] = @yellow_face[3]
			@yellow_face[3] = @red_face[3]
			@red_face[3] = tmp

			tmp = @white_face[6]
			@white_face[6] = @orange_face[2]
			@orange_face[2] = @yellow_face[6]
			@yellow_face[6] = @red_face[6]
			@red_face[6] = tmp

			tmp = @green_face[0]
			@green_face[0] = @green_face[6]
			@green_face[6] = @green_face[8]
			@green_face[8] = @green_face[2]
			@green_face[2] = tmp
			tmp = @green_face[1]
			@green_face[1] = @green_face[3]
			@green_face[3] = @green_face[7]
			@green_face[7] = @green_face[5]
			@green_face[5] = tmp
		else
			@movement_history.push('g') if save_history
			tmp = @white_face[0]
			@white_face[0] = @red_face[0]
			@red_face[0] = @yellow_face[0]
			@yellow_face[0] = @orange_face[8]
			@orange_face[8] = tmp

			tmp = @white_face[3]
			@white_face[3] = @red_face[3]
			@red_face[3] = @yellow_face[3]
			@yellow_face[3] = @orange_face[5]
			@orange_face[5] = tmp

			tmp = @white_face[6]
			@white_face[6] = @red_face[6]
			@red_face[6] = @yellow_face[6]
			@yellow_face[6] = @orange_face[2]
			@orange_face[2] = tmp

			tmp = @green_face[0]
			@green_face[0] = @green_face[2]
			@green_face[2] = @green_face[8]
			@green_face[8] = @green_face[6]
			@green_face[6] = tmp
			tmp = @green_face[1]
			@green_face[1] = @green_face[5]
			@green_face[5] = @green_face[7]
			@green_face[7] = @green_face[3]
			@green_face[3] = tmp
		end
	end

	def rotate_white(direction, save_history=true)
		if direction == :cw
			@movement_history.push('W') if save_history
			tmp = @orange_face[2]
			@orange_face[2] = @green_face[2]
			@green_face[2] = @red_face[2]
			@red_face[2] = @blue_face[2]
			@blue_face[2] = tmp

			tmp = @orange_face[1]
			@orange_face[1] = @green_face[1]
			@green_face[1] = @red_face[1]
			@red_face[1] = @blue_face[1]
			@blue_face[1] = tmp

			tmp = @orange_face[0]
			@orange_face[0] = @green_face[0]
			@green_face[0] = @red_face[0]
			@red_face[0] = @blue_face[0]
			@blue_face[0] = tmp

			tmp = @white_face[0]
			@white_face[0] = @white_face[6]
			@white_face[6] = @white_face[8]
			@white_face[8] = @white_face[2]
			@white_face[2] = tmp
			tmp = @white_face[1]
			@white_face[1] = @white_face[3]
			@white_face[3] = @white_face[7]
			@white_face[7] = @white_face[5]
			@white_face[5] = tmp
		else
			@movement_history.push('w') if save_history
			tmp = @orange_face[2]
			@orange_face[2] = @blue_face[2]
			@blue_face[2] = @red_face[2]
			@red_face[2] = @green_face[2]
			@green_face[2] = tmp

			tmp = @orange_face[1]
			@orange_face[1] = @blue_face[1]
			@blue_face[1] = @red_face[1]
			@red_face[1] = @green_face[1]
			@green_face[1] = tmp

			tmp = @orange_face[0]
			@orange_face[0] = @blue_face[0]
			@blue_face[0] = @red_face[0]
			@red_face[0] = @green_face[0]
			@green_face[0] = tmp

			tmp = @white_face[0]
			@white_face[0] = @white_face[2]
			@white_face[2] = @white_face[8]
			@white_face[8] = @white_face[6]
			@white_face[6] = tmp
			tmp = @white_face[1]
			@white_face[1] = @white_face[5]
			@white_face[5] = @white_face[7]
			@white_face[7] = @white_face[3]
			@white_face[3] = tmp
		end
	end

	def scamble(movements=20)
		movements.times do
			face = rand(6)
			direction = rand(2)
			if direction == 0
				direction = :cw
			else
				direction = :ccw
			end
			case face
				when 0 then face_rotate(:white, direction)
				when 1 then face_rotate(:green, direction)
				when 2 then face_rotate(:red, direction)
				when 3 then face_rotate(:blue, direction)
				when 4 then face_rotate(:orange, direction)
				when 5 then face_rotate(:yellow, direction)
			end
		end
	end

	def history_get_move(move)
		case @movement_history[move]
			when 'W' then return :white, :cw
			when 'w' then return :white, :ccw
			when 'G' then return :green, :cw
			when 'g' then return :green, :ccw
			when 'R' then return :red, :cw
			when 'r' then return :red, :ccw
			when 'B' then return :blue, :cw
			when 'b' then return :blue, :ccw
			when 'O' then return :orange, :cw
			when 'o' then return :orange, :ccw
			when 'Y' then return :yellow, :cw
			when 'y' then return :yellow, :ccw
		end
	end

	def history_next()
		face, direction = history_get_move(@current_pos)
		face_rotate(face, direction, false)
		@current_pos += 1
	end

	def history_back()
		face, direction = history_get_move(@current_pos-1)
		if direction == :cw
			direction = :ccw
		else
			direction = :cw
		end
		face_rotate(face, direction, false)
		@current_pos -= 1
	end

	def goto_next()
		goto_move(@current_pos+1)
	end

	def goto_back()
		goto_move(@current_pos-1)
	end

	def goto_first()
		goto_move(0)
	end

	def goto_last()
		goto_move(@movement_history.length)
	end

	def goto_move(move)
		return if move < 0 or move > @movement_history.length

		while @current_pos != move
				if @current_pos > move
					history_back
				else
					history_next
				end
		end
	end

	private :representation, :rotate_red, :rotate_orange, :rotate_yellow, :rotate_blue, :rotate_green, :rotate_white
end

