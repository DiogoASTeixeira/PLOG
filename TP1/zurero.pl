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

game(1):-
	create_board(Board),!,
	(loopPvP(white, Board) ->
	!, write('The Game is Over');
	!,write('Game Over')),nl.

game(2):-
	create_board(Board),!,
	write('AI Difficulty:'),nl,
	write('1- Smart as a brick'),nl,
	write('2- Smart as a slightly intelligent brick'),nl,
	write('3- Actually tries to play'),nl,
	write('Select option: '),
	read(AIdifficulty),

	(loopAI(AIdifficulty, white, Board) ->
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

loopAI(AIdifficulty, Player, Board):-
	!,
	print_board(Board),
	ai_decision(AIdifficulty, 'O', Board, Direction, Line),
	throw_piece(Direction, Line, 'O', Board, NewBoard) ->
	(victory_check(white, NewBoard) ->
		!,true
	;
		change_player(Player, Opponent),
		loopPvAI(AIdifficulty, Opponent, NewBoard)).

loopPvAI(AIdifficulty, Player, Board):-
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
				loopAI(AIdifficulty, Opponent, NewBoard))
		%ELSE throw_piece - Impossible move
		;	write('Invalid move!'),
			nl,
			loopPvAI(AIdifficulty, Player, Board))
	%ELSE of input_direction - Invalid Direction
	;	loopPvAI(AIdifficulty, Player, Board)).

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


