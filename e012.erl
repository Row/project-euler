%,Problem,12
-module(e012).
-export([solve/0, is_prime/1]).
-define(MAX, 100000).

is_prime(P) ->
    R = round(math:sqrt(P)),
    is_prime(P, R).

is_prime(_P, 1) ->
    true;
is_prime(P, N) when P rem N =:= 0 ->
    false;
is_prime(P, N) ->
    is_prime(P, N - 1).
	
factors(PrimeCache, N) ->
	factors(PrimeCache, N, N, []).

factors(PrimeCache, _N, 1, Factors) ->
	{PrimeCache, Factors};
factors(PrimeCache, N, 2, Factors) -> 
	factors(PrimeCache, N div 2, N div 2, [2|Factors]);
factors(PrimeCache, N, D, Factors) when N rem 2 =:= 1 andalso N rem D =:= 0 ->
	case array:get(D, PrimeCache) orelse is_prime(D) of
		true ->
	    	factors(array:set(D, true, PrimeCache), N div D, N div D, [D|Factors]);
		false ->
	    	factors(PrimeCache, N, D - 1, Factors)
    end;
factors(PrimeCache, N, D, Factors) ->
	factors(PrimeCache, N, D - 1, Factors).

triangle_num(X) ->
	round(0.5 * X * (X + 1)).

count_val(L, V) ->
	count_val(L, V, 0, []).

count_val([],_V, Sum, Acc) ->
	{Sum, Acc};
count_val([V|T], V, Sum, Acc) ->
	count_val(T, V, Sum + 1, Acc);
count_val([H|T], V, Sum, Acc) ->
	count_val(T, V, Sum, [H|Acc]).

count_pow([]) ->
	[];
count_pow([H|T]) ->
	{Count, T1} = count_val(T, H),
	[2 + Count|count_pow(T1)]. % 1 for H and Algo + 1

product([]) ->
	1;
product([H|T]) ->
	H * product(T).

solve() ->
	A = array:new({default,false}),
    solve(A, ?MAX).

 solve(PrimeCache, N) ->   
    TriangleNumber = triangle_num(N),
    {PrimeCacheUp, Factors} = factors(PrimeCache, TriangleNumber),
    Divisors = product(count_pow(Factors)),
    p(Factors),
    io:format(" = ~p, n = ~p, divisors = ~p~n",[TriangleNumber, N, Divisors]),
    %io:format("~p", [PrimeCacheUp]),
    case Divisors > 500 of
    	true ->
    		TriangleNumber;
		false ->
			solve(PrimeCacheUp, N + 1)
	end.
 
p([H]) ->
	io:format("~p", [H]);
p([H|T]) ->
	io:format("~p * ", [H]),
	p(T).

	
