%-------- EASY MODE ---------
easy_mode(Piece, Board, Direction, NWin):-
	valid_moves(Board, HList, VList, Piece),
	try_win(Board, HList, VList, Piece, NWin, Direction).

try_win(Board, HList, VList, Piece, NWin, Direction):- %If there is a winning play, the bot will perform it
	get_winning_play(Board, HList, VList, Piece, NWin, Direction).

try_win(_, HList, VList, _, NWin, Direction):- %Otherwise, it will choose among possible plays
	my_random(1,2,Rand),
	use_list(Rand, HList, VList, Direction, NWin).

get_winning_play(Board, HList, _, Piece, NWin, Direction):-
	get_winning_hor(Board, HList, Piece, NWin, Direction).

get_winning_play(Board, _, VList, Piece, NWin, Direction):-
	get_winning_vert(Board, VList, Piece, NWin, Direction).

get_winning_hor(Board, [X|Tail], Piece, X, right):-
	X =< Tail,
	player_piece(Player, Piece),
	throw_piece(right, X, Piece, Board, BoardOut),
	check_win(Player, BoardOut).

get_winning_hor(Board, [X|Tail], Piece, X, left):-
	X =< Tail,
	player_piece(Player, Piece),
	throw_piece(left, X, Piece, Board, BoardOut),
	check_win(Player, BoardOut).

get_winning_hor(Board, [X|Tail], Piece, NWin, Direction):-
	X =< Tail,
	Xn is X + 1,
	get_winning_hor(Board, [Xn|Tail], Piece, NWin, Direction).

get_winning_vert(Board, [X|Tail], Piece, X, up):-
	X =< Tail,
	player_piece(Player, Piece),
	throw_piece(up, X, Piece, Board, BoardOut),
	check_win(Player, BoardOut).

get_winning_vert(Board, [X|Tail], Piece, X, down):-
	X =< Tail,
	player_piece(Player, Piece),
	throw_piece(down, X, Piece, Board, BoardOut),
	check_win(Player, BoardOut).

get_winning_vert(Board, [X|Tail], Piece, NWin, Direction):-
	X =< Tail,
	Xn is X + 1,
	get_winning_hor(Board, [Xn|Tail], Piece, NWin, Direction).


%------- NORMAL MODE ------------
normal_mode(Piece, Board, Direction, NWin):-
	valid_moves(Board, HList, VList, Piece),
	try_win(Board, HList, VList, Piece, NWin, Direction).

normal_mode(Piece, Board, Direction, Line):-
	best_play(Board, HList, VList, Piece, Direction, Line).

best_play(Board, HList, VList, Piece, Direction, Line):-
	best_playH(Board, HList, Piece, DirectionH, LineH, WeightH),
	best_playV(Board, VList, Piece, DirectionV, LineV, WeightV),
	decide_best(DirectionH, LineH, WeightH, DirectionV, LineV, WeightV, Direction, Line).

best_playH(Board, [X|Tail], Piece, DirectionH, LineH, WeightH):-
	X =< Tail,
	throw_piece(right, X, Piece, Board, BoardOut),
	calc_weight(BoardOut, Piece, WeightR),
	throw_piece(left, X, Piece, Board, BoardOut),
	calc_weight(BoardOut, Piece, WeightL),
	choose_weight(right, WeightR, left, WeightL, DirectionH, WeightH),
	Xn is X+1,
	best_playH(Board, [Xn|Tail], Piece, DirectionH, LineH, WeightH).


best_playV(Board, [X|Tail], Piece, DirectionV, LineV, WeightV):-
	X =< Tail,
	player_piece(Player, Piece),
	throw_piece(up, X, Piece, Board, BoardOut),
	calc_weight(BoardOut, Piece, WeightU),
	throw_piece(down, X, Piece, Board, BoardOut),
	calc_weight(BoardOut, Piece, WeightD),
	choose_weight(up, WeightU, down, WeightD, X, DirectionV, WeightV, LineV),
	Xn is X+1,
	best_playV(Board, [Xn|Tail], Piece, DirectionV, LineV, WeightV).


choose_weight(Dir1, Weight1, Dir2, Weight2, X, Dir1, Weight1, X):-
	Weight1 > Weight2.
choose_weight(Dir1, Weight1, Dir2, Weight2, X, Dir2, Weight2, X).

decide_best(DirectionH, LineH, WeightH, _, _, WeightV, DirectionH, LineH):-
	WeightH > WeightV.
decide_best(_, _, _, DirectionV, LineV, _, DirectionV, LineV).

use_list(1, HList, _, Direction, Line):-
	my_random(1,2, Rand),
	direction_hor(Rand, HList, Direction, Line).

use_list(2, _, VList, Direction, Line):-
	my_random(1,2, Rand),
	direction_vert(Rand, VList, Direction, Line).

direction_hor(1, [First,Last|[]], right, Line):- %RIGHT
	my_random(First, Last, Line).
direction_hor(2, [First,Last|[]], left, Line):- %LEFT
	my_random(First, Last, Line).

direction_vert(1, [First,Last|[]], up, Line):- %UP
	my_random(First, Last, Line).
direction_vert(2, [First,Last|[]], down, Line):- %DOWN
	my_random(First, Last, Line).

%_______________%

valid_moves(Board, HList, VList, Piece):-
	valid_hor(Board, HList, 1, Piece),
	valid_vert(Board, VList, 1, Piece).

valid_hor(Board, [N|HList], N, Piece):-
	throw_piece(right, N, Piece, Board, BoardOut),
	valid_hor_last(Board, HList, 19, Piece).
valid_hor(Board, HList, N, Piece):-
	NN is N+1,
	valid_hor(Board, HList, NN, Piece).

valid_hor_last(Board, [N|[]], N, Piece):-
	throw_piece(right, N, Piece, Board, BoardOut).
valid_hor_last(Board, HList, N, Piece):-
	NN is N-1,
	valid_hor_last(Board, HList, NN, Piece).

valid_vert(Board, [N|VList], N, Piece):-
	throw_piece(up, N, Piece, Board, BoardOut),
	valid_vert_last(Board, VList, 19, Piece).
valid_vert(Board, VList, N, Piece):-
	NN is N+1,
	valid_vert(Board, VList, NN, Piece).

valid_vert_last(Board, [N|[]], N, Piece):-
	throw_piece(up, N, Piece, Board, BoardOut).
valid_vert_last(Board, VList, N, Piece):-
	NN is N-1,
	valid_vert_last(Board, VList, NN, Piece).

calc_weight(Board, Piece, Weigth).
