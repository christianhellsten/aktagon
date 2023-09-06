:- module(magic_square, [magic_square/1]).
% Import the clpfd library which provides constraints over finite domains
:- use_module(library(clpfd)).

% Define the magic_square functor that takes a list (Square) as an argument
magic_square(Square) :-
    % Assign the Square list to contain variables A through I
    Square = [A,B,C,D,E,F,G,H,I],

    % Constrain each variable in Square to be a value between 1 and 9
    Square ins 1..9,           % Each cell is in the domain from 1 to 9

    % Assert that all variables in Square must have distinct values
    all_different(Square),    % All cells must have different values

    % The following constraints ensure that the sum of numbers in each 
    % row, column, and diagonal is equal. The exact sum value is represented by 'Sum'.

    % Row constraints: Each row should sum up to the value 'Sum'
    A+B+C #= Sum,
    D+E+F #= Sum,
    G+H+I #= Sum,

    % Column constraints: Each column should sum up to the value 'Sum'
    A+D+G #= Sum,
    B+E+H #= Sum,
    C+F+I #= Sum,

    % Diagonal constraints: Both the diagonals should sum up to the value 'Sum'
    A+E+I #= Sum,  % From top-left to bottom-right diagonal
    C+E+G #= Sum,  % From top-right to bottom-left diagonal

    % Try to find a solution that satisfies all the constraints
    label(Square).
