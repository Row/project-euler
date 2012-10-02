%,Problem,12
-module(e012).
-export([solve/0]).

perfect_square_corr(N, Sqrt) when N == Sqrt*Sqrt ->
	-1;
perfect_square_corr(_N, _Sqrt) ->
	0.
	

divisors(N) ->
	Sqrt = math:sqrt(N),
	S =	perfect_square_corr(N, Sqrt),
	divisors(N, round(Sqrt), S).


divisors(_N, C, Nod) when 1 > C ->
	Nod;
divisors(N, C, Nod) when N rem C == 0 ->
	divisors(N, C - 1, Nod + 2);
divisors(N, C, Nod) ->
	divisors(N, C - 1, Nod).

solve() ->
	solve(0, 0).		
solve(N, T) ->
	case divisors(T) > 500 of
		true -> 
			{T};
		false -> 
			solve(N + 1, T + N)
	end.

