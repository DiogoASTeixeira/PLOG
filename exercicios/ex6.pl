square(X, Y):- Y is X*X.

map([], _, []).
map([Head|Tail], Function, [Head2|Tail2]):-
	applyFunction(Function, [Head, Head2]),
	map(Tail, Function, Tail2).

applyFunction(Function, V):- R =.. [Function| V], R.
