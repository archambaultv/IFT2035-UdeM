%% subst(+E1, +E2, +X, -V)
%% indique que la substitution de X par V dans E1 renvoie E2.
%% On présume que V est fermé!


subst(int(N), int(N), _, _).
subst(id(X), V, id(X), V). 
subst(id(Y), id(Y), id(X), _) :- X \= Y.
subst(lambda(X, E), lambda(X, E), X, _).
subst(lambda(Y, Ea), lambda(Y, Eb), X, V) :-
      X \= Y, subst(Ea, Eb, X, V).
subst(app(E1a, E2a), app(E1b, E2b), X, V) :-
      subst(E1a, E1b, X, V), subst(E2a, E2b, X, V).

%% reduce(+E, -V)
%% indique que l’évaluation de E renvoie V.
reduce(int(N), int(N)).
reduce(lambda(X, B), lambda(X, B)).
reduce(app(E1, E2), V) :-
      reduce(E1, lambda(X, B)),
      reduce(E2, V2),
      subst(B, E, X, V2),
      reduce(E, V).


%% Mode de passage d'argument
%%   par valeur car il y a reduce(E2, V2) et on implémente subst avec des valeurs

%% L'autre passage :
%%  Il suffit de passer l'expression et non sa valeur
reduceNom(int(N), int(N)).
reduceNom(lambda(X, B), lambda(X, B)).
reduceNom(app(E1, E2), V) :-
      reduceNom(E1, lambda(X, B)),
      %reduce(E2, V2),
      subst(B, E, X, E2),
      reduce(E, V).

%% Portée statique, car la substitution se fait partout d'un seul coup
%% La façon la plus facile de s'en convaincre est de faire un exemple
%% Voici un bout de code Haskell qui ferait la différence
%% let foo = 1
%      identite = \x -> foo
%% in let foo = 2
%%    in identite 0

%% Dans notre language
%% reduce(app(lambda(id(foo),
%% 		  app(lambda(id(identite),
%% 			     app(lambda(id(foo), app(id(identite),int(0))),
%% 				 int(2))),
%% 		      lambda(id(x), id(foo)))),
%% 	   int(1)),
%%        X).

%% X = int(1).
