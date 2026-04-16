% edge(From, To, Cost)
edge(s, a, 2). 
edge(s, b, 4).
edge(a, c, 3).
edge(b, c, 1).
edge(c, g, 2).

% heuristic h(Node, Value)
h(s, 7). 
h(a, 6). 
h(b, 2). 
h(c, 1). 
h(g, 0).

% f = g + h
f(Node, G, F) :-
    h(Node, H),
    F is G + H.

% Print list helper
print_list([]).
print_list([[F,G,N,_]|T]) :-
    write('('), write(N), write(', f='), write(F), write(', g='), write(G), write(') '),
    print_list(T).

% A* start
astar(Start, Goal) :-
    write('Starting A* Search...'), nl,
    f(Start, 0, Fstart),
    astar_search([[Fstart, 0, Start, [Start]]], [], Goal).

% Goal condition
astar_search([[_, _, Goal, Path]|_], Closed, Goal) :-
    reverse(Path, FinalPath),
    write('Final CLOSED: '), write(Closed), nl,    write('Goal Found!'), nl,
    write('Optimal Path: '), write(FinalPath), nl, !.

% Main loop
astar_search([[F, G, Current, Path]|Open], Closed, Goal) :-
    nl,
    write('Expanding: '), write(Current),
    write('  f='), write(F),
    write('  g='), write(G), nl,

    write('OPEN: '), print_list([[F,G,Current,Path]|Open]), nl,
    write('CLOSED: '), write(Closed), nl,

    findall([NewF, NewG, Next, [Next|Path]],
            (edge(Current, Next, Cost),
             NewG is G + Cost,
             f(Next, NewG, NewF),
             \+ member(Next, Path)),
            Children),

    append(Open, Children, TempOpen),
    sort(TempOpen, NewOpen),

    astar_search(NewOpen, [Current|Closed], Goal).