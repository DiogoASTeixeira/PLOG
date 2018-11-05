:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').

play:-
	read(Word),
	write(Word),
	nl,
	create_board(Board),
	print_board(Board),
	play_aux('Black',Board).

play_aux(Player, Board):-
	player_piece(Player, Piece).

