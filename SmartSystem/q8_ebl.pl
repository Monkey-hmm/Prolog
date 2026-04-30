:- dynamic general_rule/2.

wings(eagle).  flies(eagle).
wings(penguin). \+ flies(penguin).

can_fly_specific(eagle) :-
    wings(eagle), flies(eagle),
    format("eagle can fly: has wings and flies~n").

generalize :-
    assert(general_rule(X, can_fly) :- (wings(X), flies(X))),
    format("Generalized: anything with wings and flight ability can fly~n").

apply_general(X) :-
    wings(X), flies(X),
    format("~w can fly (by general rule)~n", [X]).

:- can_fly_specific(eagle).
:- generalize.
:- apply_general(eagle).
