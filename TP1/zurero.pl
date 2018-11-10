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

add_pieces(Board, NewBoard) :-
	set_piece(10,10,'X', Board, Board1),
	set_piece(10,11,'X', Board1, Board2),
	set_piece(10,12,'X', Board2, Board3),
	set_piece(10,13,'X', Board3, Board4),
	set_piece(10,14,'X', Board4, NewBoard).

game:-
	create_board(Board),!,
	%add_pieces(Board, NBoard), %Function for testing purposes
	(loop(white, Board) ->
	!, write('The Game is Over');
	!,write('Game Over')),nl.

loop(Player, Board):-
	!,
	print_board(Board),
	write(Player),
	(input_direction(Direction)->
		input_number(Input2),
		player_piece(Player, Piece),
		(throw_piece(Direction, Input2, Piece, Board, NewBoard) ->
			(victory_check(Player, NewBoard) ->
				!,true
			;	change_player(Player, Opponent),
				loop(Opponent, NewBoard))
		%ELSE throw_piece - Impossible move
		;	write('THROW'),
			loop(Player, Board))
	%ELSE of input_direction - Invalid Direction
	;		write('Input'),
	loop(Player, Board)).

victory_check(Player, Board):-
	check_win(Player, Board),
	!,
	print_board(Board).
victory_check(Player, Board):-
	change_player(Player, Opponent),
	check_win(Opponent, Board),
	!,
	print_board(Board).


input_direction(Direction):- 
	write(' it\'s your turn.\n Write the direction (left, right, up, down) that you want to throw: '),
	read(Input1),
	process_direction(Input1, Direction),
	nl.

input_number(Input2):-
	write('Now write the line or column number: '),
	read(Input2).


