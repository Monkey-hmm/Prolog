symptom(p1, fever). symptom(p1, cough). symptom(p1, headache).

disease(flu,     [fever, cough]).
disease(malaria, [fever, headache]).
disease(cold,    [cough]).

has_all(_, []).
has_all(P, [S|T]) :- symptom(P, S), has_all(P, T).

all_diagnoses(P, Ds) :-
    findall(D, (disease(D, S), has_all(P, S)), Ds).

best_diagnosis(P, Best) :-
    findall(D-L, (disease(D, S), has_all(P, S), length(S, L)), Pairs),
    sort(1, @>=, Pairs, [Best-_|_]).

:- all_diagnoses(p1, Ds), format("All possible: ~w~n", [Ds]).
:- best_diagnosis(p1, B), format("Best match: ~w~n", [B]).
