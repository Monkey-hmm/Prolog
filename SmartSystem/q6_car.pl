symptom(car1, overheats).  symptom(car1, low_coolant).
symptom(car2, no_start).   symptom(car2, dead_battery).

problem(P, radiator_issue) :-
    symptom(P, overheats), symptom(P, low_coolant),
    format("Reason: overheats + low coolant~n").
problem(P, battery_issue) :-
    symptom(P, no_start), symptom(P, dead_battery),
    format("Reason: no start + dead battery~n").

diagnose(P) :-
    (problem(P, Prob) ->
        format("~w problem: ~w~n", [P, Prob])
    ;
        format("~w: unknown problem~n", [P])).

:- diagnose(car1).
:- diagnose(car2).
