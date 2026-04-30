% Clauses: (~power OR fault) and (power)
% ~power OR fault  =>  power -> fault

clause1(fault)  :- power.
clause2(power).

prove(fault) :-
    format("Step 1: power is given~n"),
    clause2(power),
    format("Step 2: applying (~power OR fault) with power => fault~n"),
    clause1(fault),
    format("Step 3: fault is derived~n").

:- (prove(fault) -> format("Conclusion: FAULT exists~n")
                 ; format("No fault~n")).
