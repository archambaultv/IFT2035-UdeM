% Relation avec redondance

axe1(_,0,0).
axe1(0,_,0).

axe2(_,0,0).
axe2(0,X,0) :- X \== 0.
