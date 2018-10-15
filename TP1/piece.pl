% Get Piece
get_piece(Ncolumn, Nrow, Board, Piece):-
	get_row(Nrow, Board, Linha),
	get_column(Ncolumn, Linha, Piece).
	
get_row(1,[Linha|_], Linha).
get_row(Nrow, [_|Tail], Linha):-
	Nlin is Nrow -1,
	get_row(Nlin, Tail, Linha).

get_column(1, [Piece|_], Piece).
get_column(Ncolumn, [_|Tail], Piece):-
	Ncol is Ncolumn-1,
	get_column(Ncol, Tail, Piece).

%Set Piece
set_piece(Ncolumn, Nrow, Piece, BoardIn, BoardOut):-
    set_row(Nrow, Ncolumn, Piece, BoardIn, BoardOut).
	
set_row(1, Ncolumn, Piece, [Head|Tail], [NewHead|Tail]):-
	set_column(Ncolumn, Piece, Head, NewHead).

set_row(Nrow, Ncolumn, Piece, [Head|Tail], [Head|NewTail]):-
	Nrow>1,
	Nlin is Nrow-1,
	set_row(Nlin, Ncolumn, Piece, Tail, NewTail).

set_column(1, Piece, [_|Tail], [Piece|Tail]).
set_column(Ncolumn, Piece, [DPiece|Tail], [DPiece|NewTail]):-
	Ncolumn>1,
	Ncol is Ncolumn-1,
	set_column(Ncol, Piece, Tail, NewTail).

%
remove_piece(Ncolumn, Nrow, BoardIn, BoardOut):-
	set_piece(Ncolumn, Nrow, freeCell, BoardIn, BoardOut).


