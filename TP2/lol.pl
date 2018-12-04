
:- use_module(library(lists)).
:- use_module(library(clpfd)).

puzzle(Puzzle):-
    Puzzle = [
        [_,_,4,1],
        [_,_,_,3],
        [_,_,_,_],
        [2,_,_,_]
    ].

sudoku:-
    puzzle(Puzzle),
    Rows = [A,B,C,D],
    write(Puzzle),nl,
    length(Puzzle, Length),
    flat(Puzzle, Tmp),
	domain(Tmp, 1, Length),
	Rows = Puzzle,
    transpose(Rows, Columns),
    write(Rows),nl,
    write(Columns),nl,
    % blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    % maplist(all_distinct, Blocks),
    label_all(Rows),
    write(Rows).

label_all([]).
label_all([H|T]):-
    labeling([],H),
    label_all(T).

flat([],[]).
flat([H|T], R):-
    flat(T,TR),
    append(H,TR,R).
