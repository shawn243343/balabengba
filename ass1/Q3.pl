% Q3

% Write a predicate sqrt_table(N, M, Result) that binds Result to the list of pairs consisting of a number and its square root, from N
% down to M, where N and M are non-negative integers, and N >= M. For example:

% sqrt_table(7, 4, Result).
% Result = [[7, 2.6457513110645907], [6, 2.449489742783178], [5, 2.23606797749979], [4, 2.0]] ;
% false.

% ?- sqrt_table(7, 8, Result).
% false.

% ?- X is sqrt(2).
% X = 1.4142135623730951.

% ?- X = sqrt(2).
% X = sqrt(2).

% base condition:
sqrt_table(N, N, [[N, Sqrt_N] |[]]):-
	Sqrt_N is sqrt(N).
% N < M return false
sqrt_table(N, M, [[N, Sqrt_N] | Mid_Res]):-
	N > M,
	New_N is N - 1,
	sqrt_table(New_N, M, Mid_Res),
	Sqrt_N is sqrt(N).