% Problem 10
-module(e010).
-export([solve/0]).

solve() ->
    sum_primes(2000000).

is_prime(P) ->
    R = round(math:sqrt(P)),
    is_prime(P, R).

is_prime(_P, 1) ->
    true;
is_prime(P, N) when P rem N =:= 0 ->
    false;
is_prime(P, N) ->
    is_prime(P, N - 1).

sum_primes(1) ->
	0;
sum_primes(P) ->
    case is_prime(P) of
		true ->
	    	P + sum_primes(P - 1);
		false ->
	    	sum_primes(P - 1)
    end.