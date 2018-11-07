% If Then
it(If, Then):- If, !, Then.
it(_,_).

% If Then Else
ite(If, Then, _):- If, !, Then.
ite(_, _, Else):- Else.
