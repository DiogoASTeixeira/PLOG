:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').

play:-
	create_board(Board),
	print_board(Board),
	%set_piece(1,2,'X', Board, BoardM),
	 set_piece(2,19,'X', Board, BoardJ),
	%set_piece(2,4,'X', BoardG, BoardJ),^

	print_board(BoardJ),
	throw_piece(down, 2, 'O', BoardJ, Board1),
	print_board(Board1).
	%play_aux('Black',Board).

%play_aux(Player, Board):-
%	player_piece(Player, Piece).

