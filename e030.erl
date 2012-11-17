-module(e030).
-export([solve/0]).

solve() ->
	solve(999999, 5).

solve(1, _P) ->
	0;
solve(Number, P) ->
	case is_sum_of_powers(Number, P) of
		true ->
			Number + solve(Number - 1, P);
		false ->
			solve(Number - 1, P)
	end.

is_sum_of_powers(Number, P) ->
	is_sum_of_powers(Number, P, Number, 0).

is_sum_of_powers(Number, _P, 0, Number) ->
	true;
is_sum_of_powers(_Number, _P, 0, _Sum) ->
	false;
is_sum_of_powers(Number, _P, _Rest, Sum) when Sum > Number ->
	false;
is_sum_of_powers(Number, P, Rest, Sum) ->
	is_sum_of_powers(Number, P, Rest div 10, Sum + round(math:pow(Rest rem 10, P))). 