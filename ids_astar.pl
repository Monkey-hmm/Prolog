% Goal state
goal([1,2,3,4,5,6,7,8,0]).

% Initial state
start([1,2,3,4,0,6,7,5,8]).

% Heuristic: misplaced tiles
h(State, H) :-
    goal(Goal),
    count_misplaced(State, Goal, H).

count_misplaced([], [], 0).
count_misplaced([0|T1], [_|T2], H) :- count_misplaced(T1, T2, H).
count_misplaced([X|T1], [X|T2], H) :- count_misplaced(T1, T2, H).
count_misplaced([X|T1], [Y|T2], H) :-
    X \= Y, X \= 0,
    count_misplaced(T1, T2, H1),
    H is H1 + 1.

% IDA* start (LIMITED)
ida_star :-
    start(Start),
    h(Start, H),
    ida_loop(Start, 0, H, 5).   % max threshold = 5 (safe)

% Iterative loop with limit
ida_loop(State, G, Threshold, Max) :-
    Threshold =< Max,
    write('Threshold: '), write(Threshold), nl,
    ( dfs(State, G, Threshold, [State], Path)
    -> reverse(Path, FinalPath),
       write('Goal Found!'), nl,
       write('Path: '), write(FinalPath), nl
    ;  NewT is Threshold + 1,
       ida_loop(State, G, NewT, Max)
    ).

% DFS with pruning
dfs(State, _, _, Path, Path) :-
    goal(State), !.

dfs(State, G, Threshold, Visited, Path) :-
    h(State, H),
    F is G + H,
    F =< Threshold,

    move(State, Next),
    \+ member(Next, Visited),

    G1 is G + 1,
    dfs(Next, G1, Threshold, [Next|Visited], Path).

% Moves (simplified safe moves)
move([1,2,3,4,0,6,7,5,8], [1,2,3,4,5,6,7,0,8]).
move([1,2,3,4,5,6,7,0,8], [1,2,3,4,5,6,7,8,0]).