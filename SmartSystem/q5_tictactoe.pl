wins(P, [P,P,P,_,_,_,_,_,_]).
wins(P, [_,_,_,P,P,P,_,_,_]).
wins(P, [_,_,_,_,_,_,P,P,P]).
wins(P, [P,_,_,P,_,_,P,_,_]).
wins(P, [_,P,_,_,P,_,_,P,_]).
wins(P, [_,_,P,_,_,P,_,_,P]).
wins(P, [P,_,_,_,P,_,_,_,P]).
wins(P, [_,_,P,_,P,_,P,_,_]).

moves(Board, Player, Boards) :-
    findall(NB, (nth1(I, Board, e), set_nth(I, Board, Player, NB)), Boards).

set_nth(1, [_|T], X, [X|T]).
set_nth(N, [H|T], X, [H|T2]) :- N>1, N1 is N-1, set_nth(N1, T, X, T2).

other(x, o). other(o, x).

minimax(Board, Player, Value, _) :-
    wins(x, Board), !, Value = 1.
minimax(Board, Player, Value, _) :-
    wins(o, Board), !, Value = -1.
minimax(Board, _, 0, _) :-
    \+ member(e, Board), !.
minimax(Board, Player, Value, Best) :-
    moves(Board, Player, Kids),
    other(Player, Opp),
    maplist(child_val(Opp), Kids, Pairs),
    (Player = x -> max_pair(Pairs, Value, Best)
                 ; min_pair(Pairs, Value, Best)).

child_val(P, B, B-V) :- minimax(B, P, V, _).

max_pair([B-V], V, B).
max_pair([B-V|T], BV, BN) :-
    max_pair(T, TV, TN),
    (V >= TV -> BV=V, BN=B ; BV=TV, BN=TN).

min_pair([B-V], V, B).
min_pair([B-V|T], BV, BN) :-
    min_pair(T, TV, TN),
    (V =< TV -> BV=V, BN=B ; BV=TV, BN=TN).

print_board([A,B,C,D,E,F,G,H,I]) :-
    format("~w|~w|~w~n~w|~w|~w~n~w|~w|~w~n", [A,B,C,D,E,F,G,H,I]).

:- Board = [x,o,x, o,e,e, e,e,e],
   minimax(Board, x, _, Best),
   format("Board after move:~n"),
   print_board(Best).
