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

