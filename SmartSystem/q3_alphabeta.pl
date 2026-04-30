children(a, [b, c]).
children(b, [d, e]).
children(c, [f, g]).

terminal(d, 3).
terminal(e, 5).
terminal(f, 2).
terminal(g, 9).

alphabeta(Node, _, _, V, _) :- terminal(Node, V).

alphabeta(Node, max, A-B, V, BestChild) :-
    children(Node, [H|T]),
    alphabeta(H, min, A-B, HV, _),
    max_ab(T, min, HV-H, A-B, V, BestChild).

alphabeta(Node, min, A-B, V, BestChild) :-
    children(Node, [H|T]),
    alphabeta(H, max, A-B, HV, _),
    min_ab(T, max, HV-H, A-B, V, BestChild).

max_ab([], _, BV-BN, _, BV, BN).
max_ab(_, _, BV-BN, _-B, BV, BN) :- BV >= B, format("Pruning (max)~n").
max_ab([H|T], P, BV-BN, A-B, FV, FN) :-
    BV < B,
    NA is max(A, BV),
    alphabeta(H, P, NA-B, HV, _),
    (HV > BV -> max_ab(T, P, HV-H, NA-B, FV, FN)
              ; max_ab(T, P, BV-BN, NA-B, FV, FN)).

min_ab([], _, BV-BN, _, BV, BN).
min_ab(_, _, BV-BN, A-_, BV, BN) :- BV =< A, format("Pruning (min)~n").
min_ab([H|T], P, BV-BN, A-B, FV, FN) :-
    BV > A,
    NB is min(B, BV),
    alphabeta(H, P, A-NB, HV, _),
    (HV < BV -> min_ab(T, P, HV-H, A-NB, FV, FN)
              ; min_ab(T, P, BV-BN, A-NB, FV, FN)).

:- alphabeta(a, max, -1000-1000, V, M), format("Value: ~w, Move: ~w~n", [V, M]).
