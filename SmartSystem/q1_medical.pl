symptom(john, fever). symptom(john, cough).
symptom(mary, fever). symptom(mary, headache).

diagnose(P, flu) :- symptom(P, fever), symptom(P, cough).
diagnose(P, malaria) :- symptom(P, fever), symptom(P, headache).

:- diagnose(john, D), format("John: ~w~n", [D]), fail ; true.
:- diagnose(mary, D), format("Mary: ~w~n", [D]), fail ; true.
