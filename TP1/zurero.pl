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
	write('Invalid direction'),nl, fail.

game:-
	create_board(Board),!,
	(loop(white, Board) ->
	true;
	write('Game Over')),nl.

loop(Player, Board):-
	!,
	print_board(Board),
	write(Player),
	(input_direction(Direction)->
		input_number(Input2),
		player_piece(Player, Piece),
		(throw_piece(Direction, Input2, Piece, Board, NewBoard) ->
			change_player(Player, Opponent),
			(check_win(Player, NewBoard) ->
				!,print_board(NewBoard),fail;
				(check_win(Opponent, NewBoard) ->
					!,print_board(NewBoard),fail;
					!,loop(Opponent, NewBoard)));
		%ELSE throw_piece
		!,loop(Player, Board));
	%ELSE of input_direction
	!,loop(Player, Board)).


input_direction(Direction):- 
	write(' it\'s your turn.\n Write the direction (left, right, up, down) that you want to throw: '),
	read(Input1),
	process_direction(Input1, Direction),
	nl.

input_number(Input2):-
	write('Now write the line or column number: '),
	read(Input2).


