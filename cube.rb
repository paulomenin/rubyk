
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
		rep = case
			when color == :white  then 'W'
			when color == :blue   then 'B'
			when color == :orange then 'O'
			when color == :red    then 'R'
			when color == :green  then 'G'
			when color == :yellow then 'Y'
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
		case
			when face == :red then rotate_red(direction, save_history)
			when face == :white then rotate_white(direction, save_history)
			when face == :green then rotate_green(direction, save_history)
			when face == :blue then rotate_blue(direction, save_history)
			when face == :yellow then rotate_yellow(direction, save_history)
			when face == :orange then rotate_orange(direction, save_history)
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
			case
				when face == 0 then face_rotate(:white, direction)
				when face == 1 then face_rotate(:green, direction)
				when face == 2 then face_rotate(:red, direction)
				when face == 3 then face_rotate(:blue, direction)
				when face == 4 then face_rotate(:orange, direction)
				when face == 5 then face_rotate(:yellow, direction)
			end
		end
	end

	def history_get_move(move)
		case
			when @movement_history[move] == 'W' then return :white, :cw
			when @movement_history[move] == 'w' then return :white, :ccw
			when @movement_history[move] == 'G' then return :green, :cw
			when @movement_history[move] == 'g' then return :green, :ccw
			when @movement_history[move] == 'R' then return :red, :cw
			when @movement_history[move] == 'r' then return :red, :ccw
			when @movement_history[move] == 'B' then return :blue, :cw
			when @movement_history[move] == 'b' then return :blue, :ccw
			when @movement_history[move] == 'O' then return :orange, :cw
			when @movement_history[move] == 'o' then return :orange, :ccw
			when @movement_history[move] == 'Y' then return :yellow, :cw
			when @movement_history[move] == 'y' then return :yellow, :ccw
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

