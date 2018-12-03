:-use_module(library(clpfd)).

fechadura(Vars):-
	Vars = [First, Second, Third],
	domain(Vars, 1, 50),

	Second #= First*2,
	Third #= Second+10,

	First + Second #> 10,

	First #= 10*A1 + A2,
	Second #= 10*_B1 + B2,
	B2 mod 2 #= 0,
	A1 mod 2 #\= A2 mod 2,

	labeling([], Vars).

guardas(Vars):-
	Vars = [S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12],
	domain(Vars, 0, 5),
	sum(Vars, #=, 12),
	S1 + S2 + S3 + S4 #= 5,
	S4 + S5 + S6 + S7 #= 5,
	S7 + S8 + S9 + S10 #= 5,
	S10 + S11 + S12 + S1 #= 5,

	labeling([], Vars).

nqueens(N, Cols) :-
	length(Cols, N),
	domain(Cols, 1, N),
	
	apply_restriction(Cols),


	all_distinct(Cols),
	labeling([],Cols).

apply_restriction([]).
apply_restriction([H|T]) :-
	restriction(H, T, 1),
	apply_restriction(T).

restriction(_, [], _).
restriction(C, [OC | T], K):-
	C  #\= OC,
	C + K #\= OC,
	C - K #\= OC,
	K1 is K + 1,
	restriction(C, T, K1).