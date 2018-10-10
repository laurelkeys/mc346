main :- read_string(current_input, "", "\r\t ", _, String), do_it(String).

% geq4(+String) true if String has 4 or more characters
geq4(X) :- length(X, L), !, L >= 4.

% intersect_in_order(+String1, +String2, -IntersectedStrings) true if the end of String1 intersects with the start of String2
intersect_in_order([], _, _) :- !, fail.
intersect_in_order(X, Y, Z) :- append(X, _, Y), !, geq4(X), Z = Y.
intersect_in_order([X|XS], Y, Z) :- intersect_in_order(XS, Y, ZZ), !, Z = [X|ZZ].

% intersect(+String1, +String2, -IntersectedStrings) true if, in some order, the strings intersect
intersect(X, Y, Z) :- intersect_in_order(Y, X, Z), !.
intersect(X, Y, Z) :- intersect_in_order(X, Y, Z), !.

% intersect_head(+List, -List') where List = [STR1, STR2, ..., STRn]
% if STR1 intersects with an STRi
%   then Head' is intersect(STR1, STRi) and Tail' is Tail\{STRi}
% else
%   List'= List
intersect_head([A], [A]) :- !. % 1 element
intersect_head([A|[B|CS]], L) :- % ≥2 elements
    (intersect(A, B, Z) -> L = [Z|CS]
                         ; intersect_head([A|CS], [Z|ZS]), L = [Z,B|ZS]).

% intersect_til_eq_then_pop(+List, -Tail')
% calls intersect_head untill List = List' then prints Head' and returns Tail'
intersect_til_eq_then_pop(L, LLL) :-
	intersect_head(L, LL),
	(L = LL -> LL = [H|T], string_chars(Str, H), print(Str), nl, LLL = T
			 ; intersect_til_eq_then_pop(LL, LLL)).

% loop_it(+List)
% loops intersect_til_eq_then_pop until Tail' = []
loop_it([]).
loop_it(L) :- intersect_til_eq_then_pop(L, T), loop_it(T).

% lines(+String, -Lines) makes Lines a list of String's lines, splitting it by newline
lines(S, SS) :- split_string(S, "\n", "\s\t\n", SS).

% chars(+Strings, -Chars) where Strings is a list of strings STRi and Chars returns a list of STRi's chars
% i.e. Strings = [STR1, ..., STRn] and CHARS = [[CH1_1, ..., CHk_1], ..., [CH1_n, ..., CHl_n]]  
%      where: |STR1| = k, STR1 = [CH1_1, ..., CHk_1]
%             |STRn| = l, STRn = [CH1_n, ..., CHl_n]
chars([W], CHS) :- string_chars(W, CH), CHS = [CH].
chars([W|WS], CHS) :- string_chars(W, CH), chars(WS, CCHS), CHS = [CH|CCHS].

% lines_chars(+String, -Chars)
lines_chars(S, CHS) :- lines(S, WS), chars(WS, CHS).

% do_it(+String) parses the input string into a list of words' chars and calls loop_it on it
do_it(S) :- lines_chars(S, CHS), loop_it(CHS), !.
