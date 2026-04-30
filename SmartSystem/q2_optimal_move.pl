children(a, [b, c]).
children(b, [d, e]).
children(c, [f, g]).

terminal(d, 3).
terminal(e, 5).
terminal(f, 2).
terminal(g, 9).

minimax(Node, _, Value, _) :- terminal(Node, Value).

minimax(Node, max, Value, Best) :-
    children(Node, Kids),
    maplist(child_val_min, Kids, Pairs),
    max_pair(Pairs, Value, Best).

minimax(Node, min, Value, Best) :-
    children(Node, Kids),
    maplist(child_val_max, Kids, Pairs),
    min_pair(Pairs, Value, Best).

child_val_max(Node, Node-V) :- minimax(Node, max, V, _).
child_val_min(Node, Node-V) :- minimax(Node, min, V, _).

max_pair([N-V], V, N).
max_pair([N-V|T], BV, BN) :-
    max_pair(T, TV, TN),
    (V >= TV -> BV=V, BN=N ; BV=TV, BN=TN).

min_pair([N-V], V, N).
min_pair([N-V|T], BV, BN) :-
    min_pair(T, TV, TN),
    (V =< TV -> BV=V, BN=N ; BV=TV, BN=TN).

:- minimax(a, max, V, M), format("Best move: ~w, Value: ~w~n", [M, V]).
