% Prints the Board, freeCell replaced with empty space ' '
print_board(Board):-
	print_row_divider(29),
	print_board_aux(Board).

print_board_aux([]).
print_board_aux([Row|Rest]):-
	write('| '),
	print_row(Row),
	print_board_aux(Rest).

print_row([]):- 
	print_row_divider(29).

print_row([freeCell|Tail]):-
	write(' | '),
	print_row(Tail).

print_row([Piece|Rest]) :-
	Piece \= freeCell,
	write(Piece),
	write('| '),
	print_row(Rest).

print_row_divider(N):-
	nl,
	print_row_divider_aux(N),
	nl.

print_row_divider_aux(0).
print_row_divider_aux(N):-
	write('--'),
	NN is N-1,
	print_row_divider_aux(NN).