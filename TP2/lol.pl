
:- use_module(library(lists)).
:- use_module(library(clpfd)).

sudoku(Puzzle) :-
	flatten(Puzzle, Tmp),
	length(Puzzle, Length),
	domain(Tmp, 1, Length),
	Rows = Puzzle,
    transpose(Rows, Columns),
    write(Rows),
    write(Columns),
    % blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    % maplist(all_distinct, Blocks),
    labeling([], Rows).

flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).