% Expressions régulières
match(RE, Str, Tail) :- append(RE, Tail, Str).
match(any, [_|Tail], Tail).
match(concat(RE1,RE2), Str, Tail) :-
    match(RE1,Str,Tail1), match(RE2, Tail1, Tail).

match(repeat(_), Str, Str).
match(repeat(RE),Str,Tail) :-
    match(RE, Str, Tail1), match(repeat(RE), Tail1, Tail).

% Ajout de or et and
match(or(RE1,_),Str,Tail):- match(RE1,Str,Tail).
match(or(_,RE2),Str,Tail):- match(RE2,Str,Tail).

match(and(RE1,RE2),Str,Tail) :- match(RE1,Str,Tail), match(RE2,Str,Tail).
