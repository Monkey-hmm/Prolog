:- dynamic(count/1).

% Graph
successor(s, a). successor(s, b).
successor(a, c). successor(a, d).
successor(b, e).
successor(c, g).
successor(e, g).

% IDS start
ids(Start, Goal) :-
    write('Starting IDS...'), nl,
    ids_iter(Start, Goal, 0).

% Iteration loop
ids_iter(Start, Goal, Depth) :-
    retractall(count(_)),
    assert(count(0)),

    write('--- Depth Limit: '), write(Depth), nl,

    (   dls(Start, Goal, Depth, [Start], RevPath)
    ->  count(N),
        reverse(RevPath, Path),
        write('Nodes Expanded: '), write(N), nl,
        write('Goal Found!'), nl,
        write('Final Path: '), write(Path), nl
    ;   count(N),
        write('Nodes Expanded: '), write(N), nl,
        write('Not found, increasing depth...'), nl, nl,
        NewDepth is Depth + 1,
        ids_iter(Start, Goal, NewDepth)
    ).

% DLS with path + counting

% Goal case
dls(Node, Goal, _, Path, Path) :-
    increment,
    write('Visiting: '), write(Node),
    write('  Path: '), write(Path), nl,
    Node = Goal.

% Continue search
dls(Node, Goal, Limit, Path, FinalPath) :-
    Limit > 0,
    increment,
    write('Visiting: '), write(Node),
    write('  Path: '), write(Path), nl,
    successor(Node, Next),
    \+ member(Next, Path),
    NewLimit is Limit - 1,
    dls(Next, Goal, NewLimit, [Next|Path], FinalPath).

% Counter increment
increment :-
    retract(count(X)),
    Y is X + 1,
    assert(count(Y)).