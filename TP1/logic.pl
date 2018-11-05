change_player('White', 'Black').
change_player('Black', 'White').

player_piece('White', 'O').
player_piece('Black', 'X').

throw_piece(right, N, Piece).
throw_piece(left, N, Piece).
throw_piece(up, N, Piece).
throw_piece(down, N, Piece).
