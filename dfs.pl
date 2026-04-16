% Graph
successor(s, a). successor(s, b).
successor(a, c). successor(a, d).
successor(b, e).
successor(c, g).
successor(e, g).

% DFS start
dfs(Start, Goal) :-
    write('Starting DFS...'), nl,
    dfs_stack([Start], [], [], Goal).
    % STACK, CLOSED, ORDER

% Goal condition
dfs_stack([Goal|Path], Closed, Order, Goal) :-
    reverse([Goal|Path], FinalPath),
    reverse([Goal|Order], FinalOrder),
    write('Goal Found!'), nl,
    write('Final Path: '), write(FinalPath), nl,
    write('Traversal Order: '), write(FinalOrder), nl,
    write('Final CLOSED: '), write(Closed), nl.

% Main DFS
dfs_stack([Current|Path], Closed, Order, Goal) :-
    write('Expanding: '), write(Current), nl,
    write('STACK: '), write([Current|Path]), nl,
    write('CLOSED: '), write(Closed), nl, nl,

    successor(Current, Next),
    \+ member(Next, [Current|Path]),
    \+ member(Next, Closed),

    dfs_stack([Next,Current|Path], [Current|Closed], [Current|Order], Goal).