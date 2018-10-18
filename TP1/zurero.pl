:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').

% Initializes empty board, with X piece on middle (10,10)
create_board(PBoard) :- 
	create_board_aux(19, [] , Board),
	set_piece(10,10,'O', Board, PBoard).

create_board_aux(0, Board, Board) :- !.
create_board_aux(N, L, Board) :-
	create_row(Row),
	N > 0,
	N1 is N-1,
	create_board_aux(N1, [Row|L], Board).

create_board_aux(N, L, Board) :-
	create_row(Row),
	N > 0,
	N1 is N-1,
	create_board_aux(N1, [Row|L], Board).

create_row(Row) :- create_row_aux(19, [], Row).

create_row_aux(0, Row, Row) :- !.
create_row_aux(N, L, Row) :- 
	N > 0, 
	N1 is N-1, 
	create_row_aux(N1, [freeCell|L], Row).

create_middle_row_aux(10, L, Row) :- 
	N > 0, 
	N1 is N-1, 
	create_row_aux(N1, ['X'|L], Row).

test_print(Valid):- 
	create_board(Board),
	print_board(Board),
	set_piece(1,2,'X',  Board, NBoard),
	check_valid_move(left, 2, NBoard, Valid),
	print_board(NBoard).

