:- use_module(library(plunit)).
:- use_module(magic_square).
:- begin_tests(magic_square_tests).

% Test to check if the magic square solution is valid
test(valid_magic_square) :-
    magic_square(Square),
    % The sum for a 3x3 magic square is always 15
    valid_magic_square(Square, 15).

% Helper predicate to validate a magic square solution
valid_magic_square([A,B,C,D,E,F,G,H,I], Sum) :-
    % Row sums
    A+B+C =:= Sum,
    D+E+F =:= Sum,
    G+H+I =:= Sum,

    % Column sums
    A+D+G =:= Sum,
    B+E+H =:= Sum,
    C+F+I =:= Sum,

    % Diagonal sums
    A+E+I =:= Sum,
    C+E+G =:= Sum.

:- end_tests(magic_square_tests).
