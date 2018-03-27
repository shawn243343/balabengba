% mycode

% FULL Name: Wenxiao Xu
% zID: z5142629
% assignment 1 : Prolog Programming
% completed date: 26/03/18

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

% Q2
% For the purposes of the examples in this question, assume that the following facts have been loaded into Prolog:
% likes(mary, apple).
% likes(mary, pear).
% likes(mary, grapes).
% likes(tim, mango).
% likes(tim, apple).
% likes(jane, apple).
% likes(jane, mango).

% Write a predicate all_like_all(Who_List, What_List) that takes a list of people Who_List and a list of items What_List and succeeds if % every person in Who_List likes every item in What_List, according to the predicate likes(Who, What). Your predicate should also succeed % if either Who_List or What_List is empty. Examples:

% ?- all_like_all([jane,tim],[apple,mango]).
% true ;
% false.

% ?- all_like_all([mary,tim],[apple,grapes]).
% false.

% ?- all_like_all([],[bananas]).
% true ;
% false.

%base condition:
all_like_all([] , [_|_]).
all_like_all([_|_], []).

%recursive condition:
all_like_all([First_people|Rest_people], [First_fruit|Rest_fruit]):-
	likes(First_people, First_fruit),
	all_like_all([First_people|Rest_people], Rest_fruit),
	all_like_all(Rest_people, [First_fruit| Rest_fruit]).



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


%Q4
% Write a predicate chop_up(List, NewList) that takes List and binds NewList to List with all sequences of successive increasing whole 
% numbers replaced by a two-item list containing only the first and last number in the sequence. An example of successive increasing
% whole numbers is: 19,20,21,22. (Note that the numbers have to be successive in the sense of increasing by exactly 1 at each step.) 
% For example:

% ?- chop_up([9,10,5,6,7,3,1], Result).
% Result = [[9, 10], [5, 7], 3, 1] ;
% false.

% ?- chop_up([1,3,2,3,4], Result).
% Result = [1, 3, [2, 4]] ;
% false.

% In this example, the sequence 9,10 has been replaced by [9,10], the sequence 5,6,7 has been replaced by [5, 7], and 2,3,4 has been 
% replaced by [2, 4].


% concat([], List2, List2).
% concat([Item|Tail1], List2, [Item|Concat_Tail1_List2]) :-
%	concat(Tail1, List2, Concat_Tail1_List2).

% length([], 0).

% length([First | Rest], Length) :-
%   length(Rest, LengthOfRest),
% 	Length is LengthOfRest + 1.


return(Start, 0, Start).
return(Start, Len, [Start, Last]) :-
	Len > 0,
	Last is Start + Len.


count(Start, [], 0, [Start]).
count(Start, [], Len, [[Start, Last]]):-
	Len > 0,
	Last is Start + Len.


%cut point
count(Start, [Next | Rest], Len, Result) :-
	Start + 1 =\= Next - Len,
	count(Next, Rest, 0, Rest_Result),
	return(Start, Len, Chunk),
	Result = [Chunk | Rest_Result].


%successive
count(Start, [Next | Rest], Len, Result) :-
	Start + 1 =:= Next - Len,
	New_len is Len + 1,
	count(Start, Rest, New_len, Rest_Result),
	Result = Rest_Result.
%base condition:

chop_up([], []).
%recursive condition:
chop_up([Start | Rest], Result) :-
	count(Start, Rest, 0 , Result).



% Q5
% For this question we consider binary expression-trees whose leaves are either of the form tree(empty, Num, empty) where Num is a 
% number, or tree(empty, z, empty) in which case we will think of the letter z as a kind of "variable". Every tree is either a leaf or of 
% the form tree(L, Op, R) where L and R are the left and right subtrees, and Op is one of the arithmetic operators '+', '-', '*', '/' (
% signifying addition, subtraction, multiplication and division).
% Write a predicate tree_eval(Value, Tree, Eval) that binds Eval to the result of evaluating the expression-tree Tree, with the variable 
% z set equal to the specified Value. For example:

% ?- tree_eval(2, tree(tree(empty,z,empty),
%                 '+',tree(tree(empty,1,empty),
%                      '/',tree(empty,z,empty))), Eval).
% Eval = 2.5 ;
% false.

% ?- tree_eval(5, tree(tree(empty,z,empty),
%                 '+',tree(tree(empty,1,empty),
%                      '/',tree(empty,z,empty))), Eval).
% Eval = 5.2 ;
% false.

%base condition
% leaf must be a number or variable z
% Value is only useful to assign variable z throughout the forest

% if node is variable z: (assign it with value)
tree_eval(Value, tree(empty, z, empty), Value).

% if node is a number: (return value of number)
tree_eval(_Value, Tree, Num) :-
	Tree = tree(empty, Num, empty),
	number(Num).

%recursive condition
% if node is operator '+':
tree_eval(Value, Tree, Eval):- 
	tree(Left_child, '+', Right_child) = Tree,
	tree_eval(Value, Left_child, Left_value),
	tree_eval(Value, Right_child, Right_value),
	Eval is Left_value + Right_value.

% if node is operator '-':
tree_eval(Value, Tree, Eval):- 
	tree(Left_child, '-', Right_child) = Tree,
	tree_eval(Value, Left_child, Left_value),
	tree_eval(Value, Right_child, Right_value),
	Eval is Left_value - Right_value.

% if node is operator '*':
tree_eval(Value, Tree, Eval):- 
	tree(Left_child, '*', Right_child) = Tree,
	tree_eval(Value, Left_child, Left_value),
	tree_eval(Value, Right_child, Right_value),
	Eval is Left_value * Right_value.

% if node is operator '/':
tree_eval(Value, Tree, Eval):- 
	tree(Left_child, '/', Right_child) = Tree,
	tree_eval(Value, Left_child, Left_value),
	tree_eval(Value, Right_child, Right_value),
	Eval is Left_value / Right_value.






