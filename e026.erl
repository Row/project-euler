-module(e026).

-export([solve/0, pow/2]).

pow(X, N) -> 
    pow(X, N, 1).
pow(_, 0, P) -> 
    P;
pow(X, N, A) -> 
    pow(X, N - 1, A * X).

match([H|T1], L) ->
	match([H|T1], L, H, true);
match(_, _) ->
	0.
match([H|T1], [H|T2], E, M) ->
	1 + match(T1, T2, E, (E =:= H andalso M));
match(_,_, _, true) ->
	-999999999999999999999999;
match(_,_,_,_) ->
	0.

solve1([], _L, B) ->
	B;
solve1([H|T], L, B) ->
	solve1(T, [H|L], max( match([H|L], lists:reverse([H|L])) , B)).

solve(1, _Incr, M) ->
	M;
solve(N, Incr, M) ->
	io:format("~p~n~n~n~n", [Incr div N]),
	solve(N - 1, Incr, max(solve1(integer_to_list(Incr div N),[], 0), M)).

solve() ->
	solve(999, pow(10, 2000), 0).
