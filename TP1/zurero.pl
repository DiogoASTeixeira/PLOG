:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').

play:-
	create_board(Board),
	print_board(Board),
	set_piece(11,10,'O', Board, Board1),
	set_piece(12,10,'O', Board1, Board2),
	set_piece(13,10,'O', Board2, Board3),
	set_piece(15,10,'O', Board3, Board4),
	set_piece(14,10,'O', Board4, Board5),

	print_board(Board5),
	check_win(white, Board5).
		%play_aux('Black',Board).

%play_aux(Player, Board):-
%	player_piece(Player, Piece).

