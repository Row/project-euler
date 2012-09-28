%,Problem,12
-module(e012).
-export([solve/0]).
-define(MAX, 500000000).

solve() ->
	Primes = array:new([{size,?MAX},{fixed,true},{default,true}]),
	P = gen_primes(Primes, 2, round(math:sqrt(?MAX-1)), ?MAX-1),
	solve(P, ?MAX - 1).

solve(Primes, 0) ->
	ok;
solve(Primes, Index) ->
	case array:get(Index, Primes) of
		true ->
			io:format("~p~n", [Index]),
			solve(Primes, Index - 1);
		false ->
			solve(Primes, Index - 1)
	end.

%	TriangleNumber = lists:sum(lists:seq(1, N)),
%	case TriangleNumber > 500 of
%		true ->
%			TriangleNumber;
%		false ->
%			solve(N + 1)
%	end.


gen_primes(Primes, Index, MaxSqrt, _Max) when Index > MaxSqrt ->
	Primes;
gen_primes(Primes, Index, MaxSqrt, Max) ->
	case array:get(Index, Primes) of
		true ->
			gen_primes(gen_primes_inner(Primes, Index, Index, Max), Index+1, MaxSqrt, Max);
		false ->
			gen_primes(Primes, Index+1, MaxSqrt, Max)
	end.

gen_primes_inner(Primes, Index, IndexInner, Max) when Index * IndexInner >= Max ->
	Primes;
gen_primes_inner(Primes, Index, IndexInner, Max) ->
	gen_primes_inner(array:set(Index * IndexInner, false, Primes), Index, IndexInner+1, Max).

	