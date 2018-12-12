:- include('prints.pl').
:- include('piece.pl').
:- include('utility.pl').
:- include('logic.pl').
:- include('board.pl').
:- include('AI.pl').
:- use_module(library(random)).
:- dynamic board/1.
:- dynamic current_player/1.

board(Board) :- create_board(Board).

current_player(white).

zurero_laig(ABoard).

assert_new_board(NewBoard):-
	retract((board(_Board):-_Body)),
	assertz(board(NewBoard)).
	
assert_new_player(Player, NewPlayer):-
	change_player(Player, NewPlayer),
	retract(current_player(Player)),
	assert(current_player(NewPlayer)).