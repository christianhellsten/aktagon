% Basic tokenization (can be improved further)
tokenize(Text, Tokens) :-
    re_split('[\\s\\.\\,\\(\\)\\[\\]\\{\\}]', Text, SplitListRaw),
    exclude(=([]), SplitListRaw, SplitList), 
    maplist(atom_string, Tokens, SplitList).

is_capitalized(Word) :-
    atom_chars(Word, [FirstLetter|_]),
    char_type(FirstLetter, upper).

% Extract a two-word named entity
ne([A, B|_], NamedEntity) :-
    is_capitalized(A),
    is_capitalized(B),
    atomic_list_concat([A, B], ' ', NamedEntity).
ne([_|Rest], NamedEntity) :-
    ne(Rest, NamedEntity).

% Extract named entities from text
extract_ne(Text, NamedEntity) :-
    tokenize(Text, Tokens),
    ne(Tokens, NamedEntity).
