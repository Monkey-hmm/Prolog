% -----------------------------
% Heuristic values
% -----------------------------
h(s, 10).
h(a, 8).
h(b, 6).
h(c, 7).
h(d, 3).
h(g, 0).

% -----------------------------
% Graph connections
% -----------------------------
edge(s, a).
edge(s, b).
edge(a, c).
edge(b, d).
edge(d, g).

% -----------------------------
% Wrapper for heuristic (important fix)
% -----------------------------
heuristic(Node, H) :-
    h(Node, H).

% -----------------------------
% Get neighbors
% -----------------------------
neighbors(Node, Neighbors) :-
    findall(N, edge(Node, N), Neighbors).

% -----------------------------
% Find best neighbor (lowest heuristic)
% -----------------------------
best_neighbor([H|T], Best) :-
    heuristic(H, HVal),
    best_neighbor(T, H, HVal, Best).

best_neighbor([], Best, _, Best).

best_neighbor([H|T], CurrentBest, BestVal, Best) :-
    heuristic(H, HVal),
    ( HVal < BestVal ->
        best_neighbor(T, H, HVal, Best)
    ;
        best_neighbor(T, CurrentBest, BestVal, Best)
    ).

% -----------------------------
% Hill Climbing Algorithm
% -----------------------------
hill_climb(Node, Goal, [Node|Path]) :-
    write('Current Node: '), write(Node), nl,
    heuristic(Node, H),
    write('Heuristic: '), write(H), nl,

    ( Node = Goal ->
        write('Goal reached!'), nl,
        Path = [],
        !
    ;
        neighbors(Node, Neighbors),
        write('Neighbors: '), write(Neighbors), nl,

        best_neighbor(Neighbors, Best),
        heuristic(Best, HB),

        write('Best Neighbor: '), write(Best),
        write(' (h='), write(HB), write(')'), nl,

        hill_climb(Best, Goal, Path)
    ).

% -----------------------------
% Start predicate
% -----------------------------
start :-
    hill_climb(s, g, Path),
    nl,
    write('Final Path: '), write(Path), nl.