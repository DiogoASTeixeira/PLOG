
:- use_module(library(lists)).
:- use_module(library(clpfd)).

puzzle(p1,Puzzle):-
    Puzzle = [
        [_,_,4,1],
        [_,_,_,3],
        [_,_,_,_],
        [2,_,_,_]
    ].
map_sudoku(p1, Map) :-
    Map = [
        [_,_,_,_],
        [1,1,1,_],
        [_,1,_,_],
        [_,_,_,_]
    ].

sudoku(Rows):-
    puzzle(p1,Puzzle),
    map_sudoku(p1, Map),
    length(Puzzle, Length),

    create_global_list(Length, GlobalList),
    flat(Map, FlatMap),
    global_cardinality(FlatMap, GlobalList),

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

create_global_list(Length, List):-
    create_global_list_aux(1, Length, List).

create_global_list_aux(Length, Length, [Length-Length|[]]).
create_global_list_aux(N, Length, [N-Length|T]):-
    NN is N+1,
    create_global_list_aux(NN, Length, T).
 
get_member(X, Y, List, Value):-
	get_row(Y, List, L),
	get_column(X, L, Value).
	
get_row(1,[L|_], L).
get_row(Y, [_|Tail], L):-
	YY is Y -1,
	get_row(YY, Tail, L).

get_column(1, [Value|_], Value).
get_column(X, [_|Tail], Value):-
	XX is X-1,
	get_column(XX, Tail, Value).


adjacent(Map, Length) :-
    adj_aux(1, Map, Length).

