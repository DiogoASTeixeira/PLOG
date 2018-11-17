:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').
:- include('AI.pl').
:- use_module(library(random)).

zurero:- 
	write('Zurero'),nl,
	write('1- Player vs Player'),nl,
	write('2- Player vs AI'),nl,
	write('Select option: '),
	read(Option),
	game(Option).

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
	set_piece(10,10,'O', Board, Board1),
	set_piece(10,11,'O', Board1, Board2),
	set_piece(10,12,'O', Board2, Board3),
	set_piece(10,13,'O', Board3, NewBoard).
	% set_piece(10,14,'O', Board4, NewBoard).

game(1):-
	create_board(Board),!,
	%add_pieces(Board, NBoard), %Function for testing purposes
	(loopPvP(white, Board) ->
	!, write('The Game is Over');
	!,write('Game Over')),nl.

game(2):-
	create_board(Board),!,
	% add_pieces(Board, NBoard), %Function for testing purposes
	(loopAI(white, Board) ->
	!, write('The Game is Over');
	!,write('Game Over')),nl.

loopPvP(Player, Board):-
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
				loopPvP(Opponent, NewBoard))
		%ELSE throw_piece - Impossible move
		;	write('Invalid move!'),
			nl,
			loopPvP(Player, Board))
	%ELSE of input_direction - Invalid Direction
	;	loopPvP(Player, Board)).

loopAI(Player, Board):-
	!,
	print_board(Board),
	normal_mode('O', Board, Direction, Line),
	throw_piece(Direction, Line, 'O', Board, NewBoard) ->
	(victory_check(white, NewBoard) ->
		!,true
	;
		change_player(Player, Opponent),
		loopPvAI(Opponent, NewBoard)).

loopPvAI(Player, Board):-
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
				loopAI(Opponent, NewBoard))
		%ELSE throw_piece - Impossible move
		;	write('Invalid move!'),
			nl,
			loopPvAI(Player, Board))
	%ELSE of input_direction - Invalid Direction
	;	loopPvAI(Player, Board)).

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


