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
