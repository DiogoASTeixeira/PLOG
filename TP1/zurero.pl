:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').

% Initializes empty board, with X piece on middle (10,10)
create_board(PBoard) :- 
	create_board_aux(19, [] , Board),
	set_piece(10,10,'X', Board, PBoard).

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


test_print:- 
	create_board(Board),
	print_board(Board),
	set_piece(7,9,'X',  Board, Board1),
	set_piece(7,10,'O',  Board1, Board2),
	set_piece(8,8,'O', Board2, Board3),
	set_piece(8,9,'X', Board3, Board4),
	set_piece(8,10,'X', Board4, Board5),
	set_piece(9,8,'O', Board5, Board6),
	set_piece(9,9,'O', Board6, Board7),
	set_piece(9,10,'O', Board7, Board8),
	set_piece(9,11,'X', Board8, Board9),
	set_piece(9,12,'O', Board9, Board10),
	set_piece(9,13,'X', Board10, Board11),
	set_piece(10,9,'O', Board11, Board12),
	set_piece(10,10,'X', Board12, Board13),
	set_piece(10,11,'O', Board13, Board14),
	set_piece(10,12,'X', Board14, Board15),
	set_piece(10,13,'O', Board15, Board16),
	set_piece(11,9,'O', Board16, Board17),
	set_piece(11,10,'X', Board17, Board18),
	set_piece(11,11,'X', Board18, Board19),
	set_piece(11,12,'X', Board19, Board20),
	set_piece(11,13,'X', Board20, Board21),

	print_board(Board21).

