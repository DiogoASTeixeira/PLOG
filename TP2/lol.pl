
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

sudoku(Rows, Map):-
    puzzle(p1,Puzzle),
    map_sudoku(p1, Map),
    length(Puzzle, Length),

    create_global_list(Length, GlobalList),
    flat(Map, FlatMap),
    global_cardinality(FlatMap, GlobalList),

    create_list_of_lists(Length, AreaValues),

    flat(Puzzle, Tmp1),
    domain(Tmp1, 1, Length),
    flat(AreaValues, Tmp2),
    domain(Tmp2, 1, Length),

    adjacent(Map, Length),
    assign_map_values(Puzzle, Map, AreaValues),

	Rows = Puzzle,
    transpose(Rows, Columns),

    % blocks(Rows, Blocks),
    maplist(all_distinct, AreaValues),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    % maplist(all_distinct, Blocks),

    label_all(Rows),
    label_all(Map).

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
 
create_list_of_lists(N, List) :-
    create_list_of_lists_aux(1,N, List) .

create_list_of_lists_aux(N, N, [H|[]]):-
    length(H,N).
create_list_of_lists_aux(I, N, [H|T]):-
    length(H, N),
    I < N,
    II is I + 1,
    create_list_of_lists_aux(II, N, T).


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
    adj_aux_x(1, Map, Length).

adj_aux_x(Length, Map, Length):-
    adj_aux_y(Length, 1, Map, Length).
adj_aux_x(X, Map, Length):-
    X > 0,
    X < Length,
    adj_aux_y(X, 1, Map, Length),
    XX is X + 1,
    adj_aux_x(XX, Map, Length).

adj_aux_y(X, Length, Map, Length):-
    get_member(X, Length, Map, Value),
    check_adjacency(X, Length, Map, Value, Length).
adj_aux_y(X, Y, Map, Length) :-
    Y > 0,
    Y < Length,
    get_member(X, Y, Map, Value),
    check_adjacency(X, Y, Map, Value, Length),
    YY is Y + 1,
    adj_aux_y(X, YY, Map, Length).

check_adjacency(X, Y, Map, Value, _Length) :-
    XX is X - 1,
    XX > 0,
    get_member(XX, Y, Map, Value).
check_adjacency(X, Y, Map, Value, Length) :-
    XX is X + 1,
    XX =< Length,
    get_member(XX, Y, Map, Value).
check_adjacency(X, Y, Map, Value, _Length) :-
    YY is Y - 1,
    YY > 0,
    get_member(X, YY, Map, Value).
check_adjacency(X, Y, Map, Value, Length) :-
    YY is Y + 1,
    YY =< Length,
    get_member(X, YY, Map, Value).


assign_map_values(Puzzle, Map, AreaValues):-
    assign_map_values_aux_x(1, Puzzle, Map, AreaValues).

assign_map_values_aux_x(X, Puzzle, Map, AreaValues):-
    assign_map_values_aux_y(X, 1, Puzzle, Map, AreaValues),
    XX is X + 1,
    assign_map_values_aux_x(XX, Puzzle, Map, AreaValues).