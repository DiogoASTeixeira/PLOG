
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


test(AreaValues):-
    append([[1,2,3], [4,5,6]],AreaValues).
sudoku(Puzzle, Map):-
    puzzle(p1,Puzzle),
    map_sudoku(p1, Map),
    length(Puzzle, Length),
    Lsquared is Length*Length,
    length(AreaValues, Lsquared),

    append(Map, FlatMap),
    append(Puzzle, FlatPuzzle),

    domain(FlatPuzzle, 1, Length),

    create_global_list(Length, GlobalList),
    global_cardinality(FlatMap, GlobalList),

    adjacent(Map, Length),
    transpose(Puzzle, Columns),

    sync_puzzle_map(Length, FlatPuzzle, FlatMap, AreaValues),
    all_distinct(AreaValues),
    maplist(all_distinct, Puzzle),
    maplist(all_distinct, Columns),

    append(FlatPuzzle, FlatMap, PandM),

    labeling([],PandM).

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

sync_puzzle_map(_, [], [], []).
sync_puzzle_map(N, [PH|PT], [MH|MT], [AH|AT]):-
    N*(MH-1) + PH mod N #= AH,
    sync_puzzle_map(N, PT, MT, AT).