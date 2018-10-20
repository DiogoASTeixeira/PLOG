:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').

test_print:- 
	create_board(Board),
	print_board(Board),
	set_piece(9,10,'O',  Board, Board1),
	set_piece(10,10,'O',  Board1, Board2),
	set_piece(8,11,'X', Board2, Board3),
	set_piece(9,11,'X', Board3, Board4),
	set_piece(10,11,'X', Board4, Board5),
	set_piece(9,12,'X', Board5, Board6),
	set_piece(10,12,'O', Board6, Board7),
	set_piece(9,13,'X', Board7, Board8),
	set_piece(9,14,'O', Board8, Board9),

	set_piece(8,10,'X', Board9, Board10),
	set_piece(8,11,'O', Board10, Board11),
	set_piece(8,12,'X', Board11, Board12),
	set_piece(8,13,'O', Board12, Board13),
	set_piece(9,14,'X', Board13, Board14),
	set_piece(9,15,'X', Board14, Board15),

	set_piece(10,15,'O', Board15, Board16),
	set_piece(10,14,'O', Board16, Board17),
	print_board(Board17).

