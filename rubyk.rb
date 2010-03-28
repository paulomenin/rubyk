require 'cube'

def command_parse(cube, command)
	case
		when command == 'quit' then return false
		when command == 'show' then cube.print_cube
		when command == 'scamble' then cube.scamble
		when command == 'next' then cube.goto_next
		when command == 'back' then cube.goto_back
		when command == 'first' then cube.goto_first
		when command == 'last' then cube.goto_last

		when command == 'W' then cube.face_rotate(:white, :cw)
		when command == 'w' then cube.face_rotate(:white, :ccw)
		when command == 'G' then cube.face_rotate(:green, :cw)
		when command == 'g' then cube.face_rotate(:green, :ccw)
		when command == 'R' then cube.face_rotate(:red, :cw)
		when command == 'r' then cube.face_rotate(:red, :ccw)
		when command == 'B' then cube.face_rotate(:blue, :cw)
		when command == 'b' then cube.face_rotate(:blue, :ccw)
		when command == 'O' then cube.face_rotate(:orange, :cw)
		when command == 'o' then cube.face_rotate(:orange, :ccw)
		when command == 'Y' then cube.face_rotate(:yellow, :cw)
		when command == 'y' then cube.face_rotate(:yellow, :ccw)

		else true
	end
	true
end

cube = Cube.new()
while true do
	print 'rubyk> '
	STDOUT.flush
	command = gets.chomp
	unless command_parse(cube, command)
		break
	end
end
