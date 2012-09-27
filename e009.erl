% Problem 9
-module(e009).
-export([solve/0]).

is_pyth(A, B, C) ->
	A * A + B * B =:= C * C.

solve() ->
	solve(998, 999, 1000).
solve(0, B, C) ->
	solve(B - 2, B - 1, C);
solve(_A, 0, C) ->
	solve(C - 3, C - 2, C - 1);	
solve(A, B, C) ->
	case A < B andalso B < C andalso A + B + C =:= 1000 andalso is_pyth(A, B, C) of
		true ->
			A * B * C;
		false ->
			solve(A - 1, B, C)
	end.
			