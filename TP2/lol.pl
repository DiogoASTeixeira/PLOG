
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- include('auxiliary.pl').

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


test:-
    flat([2,[1,[a,b,c],3],[4]], A),
    write(A).

sudoku(Puzzle, Map):-
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
    global_cardinality(Tmp2, GlobalList),

    adjacent(Map, Length),
    transpose(Puzzle, Columns),


    % blocks(Puzzle, Blocks),
    maplist(all_distinct, AreaValues),
    maplist(all_distinct, Puzzle),
    maplist(all_distinct, Columns),

    separate_values_in_map(Puzzle, Map, AreaValues),

    % label_all(AreaValues),
    label_all(Puzzle),
    label_all(Map).

adjacent(Map, Length) :-
    adj_aux_x(1, Map, Length).

adj_aux_x(Length, Map, Length):-
    adj_aux_y(Length, 1, Map, Length).
adj_aux_x(X, Map, Length):-
    X #> 0,
    X #< Length,
    adj_aux_y(X, 1, Map, Length),
    XX #= X + 1,
    adj_aux_x(XX, Map, Length).

adj_aux_y(X, Length, Map, Length):-
    get_member(X, Length, Map, Value),
    check_adjacency(X, Length, Map, Value, Length).
adj_aux_y(X, Y, Map, Length) :-
    Y #> 0,
    Y #< Length,
    get_member(X, Y, Map, Value),
    check_adjacency(X, Y, Map, Value, Length),
    YY #= Y + 1,
    adj_aux_y(X, YY, Map, Length).

check_adjacency(X, Y, Map, Value, _Length) :-
    XX #= X - 1,
    XX #> 0,
    get_member(XX, Y, Map, Value).
check_adjacency(X, Y, Map, Value, Length) :-
    XX #= X + 1,
    XX #=< Length,
    get_member(XX, Y, Map, Value).
check_adjacency(X, Y, Map, Value, _Length) :-
    YY #= Y - 1,
    YY #> 0,
    get_member(X, YY, Map, Value).
check_adjacency(X, Y, Map, Value, Length) :-
    YY #= Y + 1,
    YY #=< Length,
    get_member(X, YY, Map, Value).
