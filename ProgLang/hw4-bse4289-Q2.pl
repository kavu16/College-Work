remove(I,L,O) :- reverse(L,LR), remove(I,LR,[],O).
remove(I,[I|Ls],Acc,O) :- remove(I,Ls,Acc,O).
remove(I,[H|Ls],Acc,O) :- remove(I,Ls,[H|Acc],O).
remove(I,[],O,O).

remove_items([],L,O) :- remove_items(L,O).
remove_items(X,X).
remove_items([X|Xs],L,O) :- remove(X,L,Out), remove_items(Xs,Out,O).


compress([],[]).
compress([X|[X|Xs]],[X|Ys]):-compress(Xs,Ys).
compress([X|Xs],[Y|Ys]):-compress(Xs,[Y|Ys]).