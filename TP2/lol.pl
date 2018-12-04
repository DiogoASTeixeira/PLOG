:- use_module(library(clpfd)).

sudoku(Puzzle) :-
	flatten(Puzzle, Tmp),
	length(Puzzle, Length),
	domain(Tmp, 1, Length),
	Rows = Puzzle,
    transpose(Rows, Columns),
    % blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    % maplist(all_distinct, Blocks),
    maplist([], Rows).

flatten2([], []) :- !.
flatten2([L|Ls], FlatL) :-
    !,
    flatten2(L, NewL),
    flatten2(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten2(L, [L]).