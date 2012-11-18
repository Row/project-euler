-module(e034).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").


solve() ->
	solve(factorial(9)).

solve(3) ->
	0;
solve(N) ->
	case is_curious_factorial(N) of
		true ->
			io:format("~p~n", [N]),
			N + solve(N - 1);
		false ->
			solve(N - 1)
	end.


factorial(0) ->
	1;
factorial(1) ->
	1;
factorial(N) ->
	N * factorial(N - 1).


is_curious_factorial(N) ->
	is_curious_factorial(N, N, 0).

is_curious_factorial(N, 0, N) ->
	true;
is_curious_factorial(_, 0, _) ->
	false;
is_curious_factorial(N, _, Sum) when Sum > N ->
	false;
is_curious_factorial(N, Rest, Sum) ->
	is_curious_factorial(N, Rest div 10, Sum + factorial(Rest rem 10)).


% Test
is_curious_factorial_test() ->
	?assertEqual(true, is_curious_factorial(145)).	

