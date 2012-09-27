% Problem 3
-module(e003).
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

solve(N, R) ->
    case N rem 2 =/= 0 andalso is_prime(R) andalso N rem R =:= 0 of 
	true ->
	    R;
	false ->
	    solve(N, R - 1)
    end.

solve() ->
    O = 600851475143,
    R = round(math:sqrt(O)),
    solve(O,R).

    
    

    

