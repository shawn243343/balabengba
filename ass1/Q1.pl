% Q1
% Write a predicate sumsq_neg(Numbers, Sum) that sums the squares of only the negative numbers % in a list of numbers. Example:
% ?- sumsq_neg([1,-3,-5,2,6,8,-2], Sum).
% Sum = 38;
% false

%base condition:
sumsq_neg([], 0).

%recursive condition: first element is positive
sumsq_neg([Positive | Tail], Sum) :-
	Positive > 0,
	sumsq_neg(Tail, Sum).

%recursive condition: second element is not positive
sumsq_neg([NonPositive | Tail], Sum) :-
	NonPositive =< 0,
	sumsq_neg(Tail , Rest),
	Sum is Rest +(NonPositive * NonPositive).



