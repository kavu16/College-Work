
time(P,T):-time(tokyo,T)=time(P,5).
time(P,T):-time(rio,T)=time(P,10).
time(P,T):-time(berlin,T)=time(P,20).
time(P,T):-time(denver,T)=time(P,25).
team([tokyo,rio,berlin,denver]).
cost([],0).
cost([X|Xs],C):-cost(Xs,C),time(X,T),C>T,!.
cost([X|Xs],C):-cost(Xs,T),time(X,C),C>T.
split(L,[X,Y],M) :- member(X,L), member(Y,L),compare(<,X,Y),subtract(L,[X,Y],M).
move(st(l,L1), st(r,L2), r(M), C) :- split(L1,M,L2),cost(M,C).
move(st(r,L1), st(l,L2), l(M), C) :- member(M,L1),cost([M],C).
trans(I,I,[],0).
trans(I,F,M|Ms,C):- move(st(l,X),st(r,Y), r(M), C1), trans(I,F,Ms,C2), C1+C2=C.

