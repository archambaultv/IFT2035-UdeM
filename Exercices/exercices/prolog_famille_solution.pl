% Famille

% House Stark
pere(rickard,brandon1).
pere(rickard,eddard).
pere(rickard,lyanna).
pere(rickard,benjen).

pere(eddard,robb).
pere(eddard,sansa).
pere(eddard,arya).
pere(eddard,brandon2).
pere(eddard,rickon).
pere(eddard,jon).

mere(lyarra,brandon1).
mere(lyarra,eddard).
mere(lyarra,lyanna).
mere(lyarra,benjen).
mere(unknown, jon).

mere(catelyn,robb).
mere(catelyn,sansa).
mere(catelyn,arya).
mere(catelyn,brandon2).
mere(catelyn,rickon).

parent(X, Y) :- pere(X, Y).
parent(X, Y) :- mere(X, Y).

grandpere(X,Y) :- pere(X,Z), parent(Z, Y).
grandmere(X,Y) :- mere(X,Z), parent(Z, Y).

freresoeur(X,Y) :- mere(Z,X), mere(Z,Y), pere(U,X), pere(U,Y), Y \= X.

% Si on voulait inclure jon dans les frere et soeur, on utiliserait
% le concept de demi frère et soeur
demifreresoeur(X, Y) :- mere(Z,X), mere(Z,Y), pere(U, X), pere(U2,Y), Y \=X, U \= U2.
demifreresoeur(X, Y) :- mere(Z,X), mere(Z2,Y), pere(U, X), pere(U,Y), Y \=X, Z \= Z2.

freresoeur2(X, Y) :- freresoeur(X, Y).
freresoeur2(X, Y) :- demifreresoeur(X, Y).

oncletante(X,Y) :- parent(Z,Y), freresoeur(Z,X).
