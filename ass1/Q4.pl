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

chop_up([], []).
chop_up([Start | Rest], Result) :-
	count(Start, Rest, 0 , Result).




