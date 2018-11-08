:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').

process_direction('right', right):-
	write('Throwing Right').
process_direction('left', left):-
	write('Throwing Left').
process_direction('up', up):-
	write('Throwing Up').
process_direction('down', down):-
	write('Throwing Down').
process_direction(_, invalid):-
	write('Invalid direction'), fail.

%quick tests
ex:- 
	read(X),
	X == 1,
	write(X).

%bigger tests
test:-
	create_board(Board),
	print_board(Board),
	set_piece(10,10,'O', Board, Board1),
	set_piece(11,11,'O', Board1, Board2),
	set_piece(12,12,'O', Board2, Board3),
	set_piece(13,13,'O', Board3, Board4),
	set_piece(14,14,'O', Board4, Board5),

	print_board(Board5),!,
	check_win(white, Board5).

game:-
	create_board(Board),!,
	loop(white, Board).

loop(Player, Board):-
	write(Player),
	write(' it\'s your turn.\n Write the direction (left, right, up, down) that you want to throw: '),
	read(Input1),
	(process_direction(Input1, Direction) ->
		nl,
		write('Now write the line or column number: '),
		read(Input2),
		player_piece(Player, Piece),
		(throw_piece(Direction, Input2, Piece, Board, NewBoard) ->
			
		change_player(Player, Opponent),
		(check_win(Player, Board) ->
			fail;
			(check_win(Opponent, Board) ->
				fail;
				loop(Player, NewBoard)
				
				)	


	;	%ELSE of process_direction
		!,loop(Player, Board)).
