%,Problem,12
-module(e012).
-export([solve/0]).

factors(N) ->
	factors(N, N div 2, 1);
	
factors(N, 0, R) ->
	io:format("~p ~p ~n", [R, N]),
	R;
factors(N, M, R) when N rem M =:= 0 ->
	factors(N, M - 1, R + 1);
factors(N, M, R) ->
	factors(N, M - 1, R).


solve() ->
	solve(300000).

solve(N) ->
	TriangleNumber = lists:sum(lists:seq(1, N)),
	case factors(TriangleNumber) > 500 of
		true ->
			TriangleNumber;
		false ->
			solve(N + 1)
	end.

	