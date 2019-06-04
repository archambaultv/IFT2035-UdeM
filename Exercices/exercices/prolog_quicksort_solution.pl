% Quicksort

quicksort([],[]).
quicksort([X|L],Y):- partition(X,L,S,G), quicksort(S,S1), quicksort(G,G1),
		     append(S1,[X|G1],Y).

partition(_,[],[],[]).
partition(X,[L | LS],[L | S],G):- L < X, partition(X,LS,S,G).
partition(X,[L | LS],S,[L | G]):- L >= X, partition(X,LS,S,G).
