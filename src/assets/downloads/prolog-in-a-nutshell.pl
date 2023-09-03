% anne has two children
parent(anne, axel).
parent(anne, victor).

% tim has two children
parent(tim, axel).
parent(tim, victor).

% tim has two parents
parent(bill, tim).
parent(sally, tim).

% anne has two parents
parent(mark, anne).
parent(jane, anne).

% Define genders
female(anne).
female(sally).
female(jane).
male(tim).
male(axel).
male(victor).
male(mark).
male(bill).

% Use rules to define relationships
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
mother(M, C) :- parent(M, C), female(M).
father(F, C) :- parent(F, C), male(F).

% Use recursion to define the concept of ancestor
ancestor(X, Z) :- parent(X, Z).
ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).
