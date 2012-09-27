% Problem 7
-module(e007).
-export([solve/0]).

is_prime(P) ->
    R = round(math:sqrt(P)),
    is_prime(P, R).

is_prime(_P, 1) ->
    true;
is_prime(P, N) when P rem N =:= 0 ->
    false;
is_prime(P, N) ->
    is_prime(P, N - 1).

% Find 10000th prime
solve() ->
    solve(2, 10001).
solve(P, 0) ->
    P - 1;
solve(P, N)->
    case is_prime(P) of
	true ->
	    solve(P + 1, N - 1);
	false ->
	    solve(P + 1, N)
    end.

