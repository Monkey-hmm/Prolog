performance(alice, high). experience(alice, 6). skills(alice, good).
performance(bob, low).  experience(bob, 3). skills(bob, average).

promote(P) :- performance(P, high), experience(P, Y), Y >= 5, skills(P, good).

explain(P) :-
    promote(P), !,
    format("~w promoted: high performance, 5+ years, good skills~n", [P]).
explain(P) :-
    format("~w not promoted: criteria not met~n", [P]).

:- explain(alice).
:- explain(bob).
