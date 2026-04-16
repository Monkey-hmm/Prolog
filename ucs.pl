% Graph
edge(s, a, 2). edge(s, b, 5).
edge(a, c, 4). edge(a, d, 7).
edge(b, e, 3).
edge(c, g, 6).
edge(e, g, 2).

% UCS start
ucs(Start, Goal) :-
    write('Starting UCS...'), nl,
    ucs_search([[0, Start]], [], Goal).

% Goal condition
ucs_search([[Cost, Goal|Path]|_], _, Goal) :-
    reverse([Goal|Path], FinalPath),
    write('Goal Found!'), nl,
    write('Optimal Path: '), write(FinalPath), nl,
    write('Total Cost: '), write(Cost), nl.

% Main UCS
ucs_search([[Cost, Current|Path]|Open], Closed, Goal) :-
    write('Expanding: '), write(Current),
    write('  Cumulative Cost = '), write(Cost), nl,

    write('OPEN: '), write([[Cost,Current|Path]|Open]), nl,
    write('CLOSED: '), write(Closed), nl,

    % Generate children with cumulative cost
    findall([NewCost, Next,Current|Path],
        (edge(Current, Next, EdgeCost),
         NewCost is Cost + EdgeCost,
         write('  -> '), write(Current), write(' to '), write(Next),
         write(' cost = '), write(NewCost), nl,
         \+ member(Next, Path)),
        Children),

    nl,
    append(Open, Children, TempOpen),
    sort(TempOpen, NewOpen),

    ucs_search(NewOpen, [Current|Closed], Goal).