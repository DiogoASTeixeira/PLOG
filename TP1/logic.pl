change_player('White', 'Black').
change_player('Black', 'White').

player_piece('White', 'O').
player_piece('Black', 'X').

%THROW RIGHT
throw_piece(right, Nrow, Piece, BoardIn, BoardOut):-
	Nrow > 0,
	Nrow < 20,
	get_piece(1, Nrow, BoardIn, Piece1),
	get_piece(2, Nrow, BoardIn, Piece2),
	(Piece1 == freeCell ->
			throw_piece_right(1, Nrow, Piece, BoardIn, BoardOut);
			(Piece2 == freeCell,
				set_piece(2, Nrow, Piece1, BoardIn, Board1),
				set_piece(1, Nrow, Piece, Board1, BoardOut))).

throw_piece(left, Nrow, Piece, BoardIn, BoardOut):-
	Nrow > 0,
	Nrow < 20,
	get_piece(19, Nrow, BoardIn, Piece1),
	get_piece(18, Nrow, BoardIn, Piece2),
	(Piece1 == freeCell ->
		throw_piece_left(19, Nrow, Piece, BoardIn, BoardOut);
		(Piece2 == freeCell,
			set_piece(18, Nrow, Piece1, BoardIn, Board1),
			set_piece(19, Nrow, Piece, Board1, BoardOut))).

throw_piece(up, Ncolumn, Piece, BoardIn, BoardOut):-
	Nrow > 0,
	Nrow < 20,
	get_piece(19, Ncolumn, BoardIn, Piece1),
	get_piece(18, Ncolumn, BoardIn, Piece2),
	(Piece1 == freeCell ->
		throw_piece_up(1, Nrow, Piece, BoardIn, BoardOut);
		(Piece2 == freeCell,
			set_piece(Ncolumn, 18, Piece1, BoardIn, Board1),
			set_piece(Ncolumn, 19, Piece, Board1, BoardOut))).
		

throw_piece_right(N, Nrow, Piece, BoardIn, BoardOut):-
	get_piece(N, Nrow, BoardIn, NPiece),
	NPiece \= freeCell,
	N > 1,
	Ncol is N - 1,
	set_piece(Ncol, Nrow, Piece, BoardIn, Board1),
	move_piece(right, N, Nrow, Board1, Board2),
	move_piece(right, Ncol, Nrow, Board2, BoardOut).

%throw_piece(left, N, Piece).
%throw_piece(up, N, Piece).
%throw_piece(down, N, Piece).

throw_piece_right(N, Nrow, Piece, BoardIn, BoardOut):-
	get_piece(N, Nrow, BoardIn, NPiece),
	NPiece \= freeCell,
	N > 1,
	Ncol is N - 1,
	set_piece(Ncol, Nrow, Piece, BoardIn, Board1),
	move_piece(right, N, Nrow, Board1, Board2),
	move_piece(right, Ncol, Nrow, Board2, BoardOut).

throw_piece_right(N, Nrow, Piece, BoardIn, BoardOut):-
	get_piece(N, Nrow, BoardIn, NPiece),
	NPiece == freeCell,
	NN is N + 1,
	throw_piece_right(NN, Nrow, Piece, BoardIn, BoardOut).
