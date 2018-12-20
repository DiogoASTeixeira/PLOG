:- use_module(library(clpfd)).

/* my_nth -> nth1 but works with elements being other lists */
my_nth(1, [X|_T], X).
my_nth(N, [_H|T], X):-
    N #> 1,
    NN #= N - 1,
    my_nth(NN, T, X).

/*get_member in matrix*/
get_member(X, Y, List, Value):-
	get_row(Y, List, L),
	get_column(X, L, Value).
get_row(1,[L|_], L).
get_row(Y, [_|Tail], L):-
	YY #= Y -1,
	get_row(YY, Tail, L).
get_column(1, [Value|_], Value).
get_column(X, [_|Tail], Value):-
	XX #= X - 1,
	get_column(XX, Tail, Value).

/* create_global_list_aux -> for global_cardinality - if puzzle size is N, list is of form [1..N - N]*/
create_global_list(Length, List):-
    create_global_list_aux(1, Length, List).
create_global_list_aux(Length, Length, [Length-Length|[]]).
create_global_list_aux(N, Length, [N-Length|T]):-
    NN #= N+1,
    create_global_list_aux(NN, Length, T).

/* label_all -> calls label to all lists in given list */
label_all([]).
label_all([H|T]):-
    labeling([],H),
    label_all(T).
