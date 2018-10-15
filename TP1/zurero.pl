:- include('prints.pl').
:- include('piece.pl').

% Initializes empty board
create_board(Board) :- 
	create_board_aux(19, [] , Board).

create_board_aux(0, Board, Board) :- !.
create_board_aux(N, L, Board) :-
	create_row(Row),
	N > 0,
	N1 is N-1,
	create_board_aux(N1, [Row|L], Board).

create_row(Row) :- create_row_aux(19, [], Row).

create_row_aux(0, Row, Row).
create_row_aux(N, L, Row) :- 
	N > 0, 
	N1 is N-1, 
	create_row_aux(N1, [freeCell|L], Row).

test_print(P):- 
	create_board(Board),
	print_board(Board),
	set_piece(19,19,'X',Board, NBoard),
	get_piece(19,19,NBoard, P),
	print_board(NBoard).