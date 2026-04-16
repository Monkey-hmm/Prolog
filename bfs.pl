% Graph
successor(s, a). successor(s, b).
successor(a, c). successor(a, d).
successor(b, e).
successor(c, g).
successor(e, g).

% BFS start
bfs(Start, Goal) :-
    write('Starting BFS...'), nl,
    bfs_queue([[Start]], [], [], Goal).
    % OPEN, CLOSED, ORDER

% Goal condition
bfs_queue([[Goal|Path]|_], Closed, Order, Goal) :-
    reverse([Goal|Path], FinalPath),
    reverse([Goal|Order], FinalOrder),
    write('Goal Found!'), nl,
    write('Final Path: '), write(FinalPath), nl,
    write('Expansion Order: '), write(FinalOrder), nl,
    write('Final CLOSED: '), write(Closed), nl.

% Main BFS
bfs_queue([[Current|Path]|Rest], Closed, Order, Goal) :-
    write('Expanding: '), write(Current), nl,
    write('OPEN: '), write([[Current|Path]|Rest]), nl,
    write('CLOSED: '), write(Closed), nl, nl,

    findall([Next,Current|Path],
        (successor(Current, Next),
         \+ member(Next, [Current|Path]),
         \+ member(Next, Closed)),
        NewPaths),

    append(Rest, NewPaths, NewOpen),
    bfs_queue(NewOpen, [Current|Closed], [Current|Order], Goal).