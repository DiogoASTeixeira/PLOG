
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- include('auxiliary.pl').
/*
    Puzzle templates
*/
puzzle(p1,Puzzle):-
    Puzzle = [
        [_,_,4,1],
        [_,_,_,3],
        [_,_,_,_],
        [2,_,_,_]
    ].
puzzle(p2, Puzzle):-
    Puzzle = [
        [_,2,_,_],
        [_,1,4,_],
        [_,_,3,_],
        [_,_,_,_]
    ].
puzzle(p3, Puzzle):-
    Puzzle = [
        [_,_,_,_,_,_,5,_],
        [_,8,_,1,7,_,_,4],
        [6,_,_,4,_,_,_,_],
        [_,_,_,_,4,_,6,3],
        [_,_,_,_,_,8,_,7],
        [_,_,4,_,6,_,_,_],
        [_,_,5,_,_,6,_,2],
        [2,_,_,_,_,_,3,_]
    ].
puzzle(p4, Puzzle):-
    Puzzle = [
        [_,_,_,1,_,6],
        [6,_,4,_,_,_],
        [1,_,2,_,_,_],
        [_,_,_,5,_,1],
        [_,_,_,6,_,3],
        [5,_,6,_,_,_]
    ].

/* 
    Map Templates
*/
map_sudoku(p1, Map) :-
    Map = [
        [_,_,_,_],
        [1,1,1,_],
        [_,1,_,_],
        [_,_,_,_]
    ].
map_sudoku(p2, Map):-
    Map = [
        [1,1,_,_],
        [1,1,_,_],
        [_,_,_,_],
        [_,_,_,_]
    ].
map_sudoku(p3, Map):-
    Map = [
        [1,1,1,1,_,_,_,_],
        [1,1,1,1,_,_,_,_],
        [_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_],
        [_,_,_,_,2,2,2,2],
        [_,_,_,_,2,2,2,2],
        [_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_]
    ].
map_sudoku(p4, Map):-
    Map = [
        [_,_,_,_,_,_],
        [1,1,1,_,_,_],
        [1,1,1,_,_,_],
        [_,_,_,_,_,_],
        [_,_,_,_,_,_],
        [2,2,2,2,2,2]
    ].

test(AreaValues):-
    append([[1,2,3], [4,5,6]],AreaValues).
sudoku(Option,Puzzle, Map):-
    puzzle(Option,Puzzle),
    map_sudoku(Option, Map),

    /*
    Start Timer
    */
    statistics(walltime, [_TimeSinceStart | [_TimeSinceLastCall]]),

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

    labeling([],PandM),
    statistics(walltime, [_NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

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