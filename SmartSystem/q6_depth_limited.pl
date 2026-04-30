children(a, [b, c]).
children(b, [d, e]).
children(c, [f, g]).
children(d, [h, i]).
children(e, [j, k]).

terminal(f, 2). terminal(g, 9).
terminal(h, 4). terminal(i, 1).
terminal(j, 7). terminal(k, 3).

heuristic(Node, 5) :- format("Heuristic at ~w~n", [Node]).

minimax_dl(Node, _, _, V) :- terminal(Node, V), !.
minimax_dl(Node, _, 0, V) :- !, heuristic(Node, V).
minimax_dl(Node, max, D, V) :-
    children(Node, Kids), D1 is D-1,
    maplist(minimax_dl_min(D1), Kids, Vs),
    max_list(Vs, V).
minimax_dl(Node, min, D, V) :-
    children(Node, Kids), D1 is D-1,
    maplist(minimax_dl_max(D1), Kids, Vs),
    min_list(Vs, V).

minimax_dl_max(D, N, V) :- minimax_dl(N, max, D, V).
minimax_dl_min(D, N, V) :- minimax_dl(N, min, D, V).

:- minimax_dl(a, max, 3, V), format("Full depth value: ~w~n", [V]).
:- minimax_dl(a, max, 1, V), format("Depth-1 value: ~w~n", [V]).
