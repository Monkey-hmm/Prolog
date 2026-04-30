:- dynamic node_count/1.
node_count(0).

inc :- retract(node_count(N)), N1 is N+1, assert(node_count(N1)).

children(a, [b, c]).
children(b, [d, e]).
children(c, [f, g]).
terminal(d, 3). terminal(e, 5). terminal(f, 2). terminal(g, 9).

minimax(Node, _, V) :- inc, terminal(Node, V).
minimax(Node, max, V) :-
    inc, children(Node, Kids),
    maplist(minimax_min, Kids, Vs), max_list(Vs, V).
minimax(Node, min, V) :-
    inc, children(Node, Kids),
    maplist(minimax_max, Kids, Vs), min_list(Vs, V).
minimax_max(N,V) :- minimax(N, max, V).
minimax_min(N,V) :- minimax(N, min, V).

ab(Node, _, _, V) :- inc, terminal(Node, V).
ab(Node, max, A-B, V) :-
    inc, children(Node, Kids), ab_max(Kids, A-B, -1000, V).
ab(Node, min, A-B, V) :-
    inc, children(Node, Kids), ab_min(Kids, A-B, 1000, V).

ab_max([], _, V, V).
ab_max(_, A-B, V, V) :- V >= B.
ab_max([H|T], A-B, Cur, FV) :-
    Cur < B, NA is max(A,Cur),
    ab(H, min, NA-B, HV),
    NV is max(Cur, HV),
    ab_max(T, NA-B, NV, FV).

ab_min([], _, V, V).
ab_min(_, A-B, V, V) :- V =< A.
ab_min([H|T], A-B, Cur, FV) :-
    Cur > A, NB is min(B,Cur),
    ab(H, max, A-NB, HV),
    NV is min(Cur, HV),
    ab_min(T, A-NB, NV, FV).

:- retract(node_count(_)), assert(node_count(0)),
   minimax(a, max, _),
   node_count(M), format("Minimax nodes: ~w~n", [M]),
   retract(node_count(_)), assert(node_count(0)),
   ab(a, max, -1000-1000, _),
   node_count(AB), format("Alpha-Beta nodes: ~w~n", [AB]).
