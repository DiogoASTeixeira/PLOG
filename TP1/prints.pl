% Prints the Board, freeCell replaced with empty space ' '
print_board(Board):-
	print_board_aux(Board).

print_board_aux([]).
print_board_aux([Row|Rest]):-
	write('|'),
	print_row(Row),
	print_board_aux(Rest).

print_row([]):- nl.
print_row([freeCell|Tail]):-
	write(' |'),
	print_row(Tail).

print_row([Piece|Rest]) :-
	Piece \= freeCell,
	write(Piece),
	write('|'),
	print_row(Rest).