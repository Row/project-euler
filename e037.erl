-module(e037).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

solve() ->
    solve(0, 11).
solve(11, _) ->
    0;
solve(Solutions, Candidate) ->
    case all_prime(Candidate) of
	true ->
	    Candidate + solve(Solutions + 1, Candidate + 2);
	false ->
	    solve(Solutions, Candidate + 2)
    end.


all_prime(N) when N < 10 ->
  is_prime(N);
all_prime(N) ->
  is_prime(N) andalso 
  lsgn_primes(N div 10) andalso
  msgn_primes(remove_most_sig(N)).


lsgn_primes(N) when N < 10 ->
    is_prime(N);
lsgn_primes(N) ->  
    is_prime(N) andalso lsgn_primes(N div 10).


msgn_primes(N) when N < 10 ->
    is_prime(N);
msgn_primes(N) ->  
    is_prime(N) andalso msgn_primes(remove_most_sig(N)).

remove_most_sig(N) ->
    remove_most_sig(N, N, 1).

remove_most_sig(N, O, D) when N < 10 ->
    O - N * D;
remove_most_sig(N, O, D) ->
    remove_most_sig(N div 10, O, D * 10).
    

is_prime(P) when P < 2 ->
    false;
is_prime(P) ->
    R = round(math:sqrt(P)),
    is_prime(P, R).

is_prime(_P, 1) ->
    true;
is_prime(P, N) when P rem N =:= 0 ->
    false;
is_prime(P, N) ->
    is_prime(P, N - 1).


% Tests 
all_prime_test() ->
    ?assert(all_prime(3797)).

remove_most_sig_test() ->
    ?assertEqual(198, remove_most_sig(2198)),
    ?assertEqual(0, remove_most_sig(2)).
