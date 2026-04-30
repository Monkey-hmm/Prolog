marks(alice, high).    coding(alice, good).   communication(alice, good).
marks(bob, high).      coding(bob, good).     communication(bob, poor).

eligible(P) :-
    marks(P, high), coding(P, good),
    format("~w is eligible~n", [P]).

hired(P) :-
    eligible(P), communication(P, good),
    format("~w is hired~n", [P]).

check(P) :-
    (hired(P) -> true ; format("~w not hired~n", [P])).

:- check(alice).
:- check(bob).
