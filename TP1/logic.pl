check_valid_move(Dir, N, Board, Valid):-
	N < 20,
	N > 0,
	check_valid_move_aux(Dir, N, Board, Valid).

check_valid_move_aux(right, N, Board, Valid):-
	get_row(N, Board, Row),
	check_row(Row, Valid).

check_valid_move_aux(left, N, Board, Valid):-
	check_valid_move_aux(right, N, Board, Valid).

check_valid_move_aux(up, N, Board, Valid) :-
	check_column(N, 0, Board, Valid).

check_valid_move_aux(down, N, Board, Valid) :-
	check_valid_move_aux(up, N, Board, Valid).

check_row([], false) :-
	write('Invalid move').

check_row([Piece|_], true):-
	Piece \= freeCell,
	write('Valid').

check_row([freeCell|Tail], Valid):-
	check_row(Tail, Valid).

check_column(Ncolumn, Nrow, Board, true):-
	get_piece(Ncolumn, Nrow, Board, Piece),
	Piece \= freeCell,
	write('Valid').

check_column(Ncolumn, Nrow, Board, Valid):-
	Nr is Nrow +1,
	Nr < 19,
	check_column(Ncolumn, Nr, Board, Valid).
	
check_column(_,_,_, false):-
	write('Invalid').
