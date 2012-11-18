-module(e035).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

% Note: Bottle neck is mainly the prime generator

solve() ->
	Primes = primes_below(1000000),
	PrimeNoZero = lists:filter(fun (X) -> not contains_zero(X) end, Primes),
	solve(PrimeNoZero).

solve([]) ->
	0;
solve([P|T]) ->
	case is_circular_prime(P, T) of 
		{true, Perm} ->
			length([P|Perm]) + solve(T -- Perm);
		{false, Perm} ->
			solve(T -- Perm)
	end.


contains_zero(0) ->
	false;
contains_zero(N) when N rem 10 =:= 0 andalso N >= 10 ->
	true;
contains_zero(N) ->
	contains_zero(N div 10).


is_circular_prime(N, Primes) ->
	is_circular_prime(shift_number(N), Primes, N, []).

is_circular_prime(N, _, N, Acc) ->
	{true, Acc};
is_circular_prime(N, Primes, InputPrime, Acc) ->
	case lists:member(N, Primes) of
		true ->
			is_circular_prime(shift_number(N), Primes, InputPrime, [N|Acc]);
		false ->
			{false, Acc}
	end.


shift_number(N) ->
	Least = integer_to_list(N rem 10),
	case N > 10 of
		true ->
			Res = Least ++ integer_to_list(N div 10);
		false ->
			Res = Least
	end,
	list_to_integer(Res).


%% True if P is a prime
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


% Generates a list of primes below N
primes_below(2) ->
    [2]; 
primes_below(N) ->
    case is_prime(N) of
        true -> 
            [N|primes_below(N - 1)];
        false ->
            primes_below(N - 1)
    end.


% Test
shift_number_test() ->
	?assertEqual(312, shift_number(123)),
	?assertEqual(10, shift_number(100)),
	?assertEqual(1, shift_number(1)).

contains_zero_test() ->
	?assert(contains_zero(10)),
	?assert(contains_zero(101)),
	?assert(not contains_zero(111)),
		?assert(not contains_zero(1)).

is_circular_prime_test() ->
	?assertMatch({true, []}, is_circular_prime(7, primes_below(10))),
	?assertMatch({true, _}, is_circular_prime(79, primes_below(1000000))).
