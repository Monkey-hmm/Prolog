:- dynamic has/1.

ask(Symptom) :-
    format("Do you have ~w? (yes/no): ", [Symptom]),
    read(Ans),
    (Ans == yes -> assert(has(Symptom)) ; true).

diagnose(flu)    :- has(fever), has(cough).
diagnose(malaria):- has(fever), has(headache).
diagnose(cold)   :- has(cough), \+ has(fever).
diagnose(unknown):- true.

run :-
    ask(fever), ask(cough), ask(headache),
    diagnose(D), !,
    format("Diagnosis: ~w~n", [D]).

:- run.
