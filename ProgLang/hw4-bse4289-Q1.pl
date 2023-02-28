%reordered code

male(tom).
male(brian).
male(kevin).
male(zhane).
male(fred).
male(jake).
male(bob).
male(stephen).
male(paul).
male(matt).
female(jennifer).
female(melissa).
female(mary).
female(sarah).
female(jane).
female(emily).


parent(tom,stephen).
parent(stephen,jennifer).
parent(jennifer,matt).
parent(melissa,brian).
parent(mary,sarah).
parent(bob,jane).
parent(paul,kevin).
parent(tom,mary).
parent(jake,bob).
parent(zhane,melissa).
parent(stephen,paul).
parent(emily,bob).
parent(zhane,mary).

grandfather(X,Y) :- male(X), parent(X,Z),parent(Z,Y).
grandmother(X,Y) :- female(X), parent(X,Z),parent(Z,Y).
grandparent(X,Y) :- parent(X,Z),parent(Z,Y).
sibling(X,Y) :- parent(Z,X), parent(Z,Y).

uncle(X,Y) :- male(X), parent(Z,Y), sibling(Z,X).
aunt(X,Y) :- female(X), parent(Z,Y), sibling(Z,X).

