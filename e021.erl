-module(e021).
-export([solve/0,d/1]).

divisors(N) ->
    divisors(N, N - 1).
divisors(_N, 1) ->
    [1];
divisors(N, D) when N rem D =:= 0 ->
    [D|divisors(N, D - 1)];
divisors(N, D) ->
    divisors(N, D - 1).

proper_divisors(D, N) ->    
    [1|[X || X <- D, lists:member(N div X, D)]]. 

d(N) ->
   lists:sum(proper_divisors(divisors(N), N)).

amicable_pairs_below(N) ->
    amicable_pairs_below(N-1, N).

amicable_pairs_below(_A, 1) ->
    0;
amicable_pairs_below(A, B) ->
    amicable_pairs_below(A, B, d(B)).

amicable_pairs_below(1, B, _A) ->
    amicable_pairs_below(B - 2, B - 1);
amicable_pairs_below(A, B, A) ->
    amicable_pairs_below(A, B, A, d(A));
amicable_pairs_below(A, B, SB) ->
    amicable_pairs_below(A - 1, B, SB).

amicable_pairs_below(A, B, A, B) ->
     io:format("A = ~p, B = ~p~n",[A, B]),
     A + B + amicable_pairs_below(A - 1, B, A);
amicable_pairs_below(A, B, A, _SA) ->
     amicable_pairs_below(A - 1, B, A).
    
solve() ->
    N = 10000,
    amicable_pairs_below(N).
