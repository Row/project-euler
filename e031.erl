-module(e031).
-export([solve/0]).

solve() ->
	Sum = 200,
	Values = [200, 100, 50, 20, 10, 5, 2, 1],
	sum_permutations(Values, Sum).

sum_permutations(_, 0)  ->
	1;
sum_permutations(_, Sum) when Sum < 0 ->
	0;
sum_permutations([], _) ->
	0;
sum_permutations(Values = [H|T], Sum) ->
	sum_permutations(T, Sum) +
	sum_permutations(Values, Sum - H).
