%,Problem,12
-module(e012).
-export([solve/0]).
-define(MAX, 100000).



factors(_Primes, 1, _N) ->
    [];
factors(Primes, P, I) ->
    %io:format("i: ~p~n",[I]),
    case array:get(I, Primes) andalso P rem I =:= 0 of
	true ->
	    [I|factors(Primes, P div I, P div I)];
	false ->
	    factors(Primes, P, I - 1)
    end.
	    

%first chek if prime
%otherwise check all primes <= swrt(N) if found prime add list
%solve(Primes, 0) ->
%    ok;
%solve(Primes, Index) ->
%	case array:get(Index, Primes) of
%		true ->
%			io:format("~p~n", [Index]),
%			solve(Primes, Index - 1);
%		false ->
%			solve(Primes, Index - 1)

%	end.
solve() ->
    TriangleNumber = lists:sum(lists:seq(1, ?MAX+1)),
    Primes = array:new([{size,TriangleNumber},{fixed,true},{default,true}]),
    P = gen_primes(Primes, 2, math:sqrt(TriangleNumber), TriangleNumber),
    io:format("~p",[P]),
    solve(P, ?MAX - 1).

 solve(Primes, N) ->   
    TriangleNumber = lists:sum(lists:seq(1, N)),
    Factors = factors(Primes, TriangleNumber, TriangleNumber),
    p(Factors),
    io:format(" = ~p~n",[TriangleNumber]).
 
p([H]) ->
	io:format("~p", [H]);
p([H|T]) ->
	io:format("~p * ", [H]),
	p(T).

 %   case factors(TriangleNumber) > 500 of
 %  	true ->	
%	    TriangleNumber;
%	false ->
%	    solve(N + 1)
 %   end.


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

	
