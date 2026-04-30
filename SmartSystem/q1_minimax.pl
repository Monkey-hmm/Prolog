children(a, [b, c]).
children(b, [d, e]).
children(c, [f, g]).

terminal(d, 3).
terminal(e, 5).
terminal(f, 2).
terminal(g, 9).

minimax(Node, max, Value) :-
    children(Node, Kids),
    maplist(minimax_min, Kids, Vals),
    max_list(Vals, Value).

minimax(Node, min, Value) :-
    children(Node, Kids),
    maplist(minimax_max, Kids, Vals),
    min_list(Vals, Value).

minimax(Node, _, Value) :-
    terminal(Node, Value).

minimax_max(Node, Value) :- minimax(Node, max, Value).
minimax_min(Node, Value) :- minimax(Node, min, Value).

:- minimax(a, max, V), format("Root value: ~w~n", [V]).
