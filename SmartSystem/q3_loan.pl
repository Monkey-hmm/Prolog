salary(alice, high).  credit(alice, good).
salary(bob, low).    credit(bob, good).

high_salary(P) :- salary(P, high).
good_credit(P)  :- credit(P, good).

loan_approved(P) :-
    format("Checking salary...~n"),
    high_salary(P),
    format("Checking credit...~n"),
    good_credit(P).

check(P) :-
    (loan_approved(P) ->
        format("~w: Loan APPROVED~n", [P])
    ;
        format("~w: Loan DENIED~n", [P])).

:- check(alice).
:- check(bob).
