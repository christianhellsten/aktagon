:- use_module(library(plunit)).
 % The code we test is saved in 'family.pl'
:- use_module(family).
:- begin_tests(ancestor_tests).

% Direct parent-child relationships
test(anne_is_ancestor_of_axel) :-
    % We use once to get rid of this warning:
    % 	PL-Unit: Test anne_is_ancestor_of_axel: Test succeeded with choicepoint
    once(ancestor(anne, axel)).

test(tim_is_ancestor_of_victor) :-
    once(ancestor(tim, victor)).

% Grandparent relationships
test(bill_is_ancestor_of_axel) :-
    once(ancestor(bill, axel)).

test(jane_is_ancestor_of_victor) :-
    once(ancestor(jane, victor)).

% Ancestor relationships with self should fail
test(anne_is_not_ancestor_of_anne, [fail]) :-
    once(ancestor(anne, anne)).

:- end_tests(ancestor_tests).
