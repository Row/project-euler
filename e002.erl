% Problem 2
-module(e002).
-export([solve/0]).


fib(N) ->
    fib(N, 0, 1).
fib(0, Current, _Next) ->
    Current;
fib(N, Current, Next) when N > 0 ->
    fib(N - 1, Next, Next + Current).

solve() ->
    solve(0).
solve(N) -> 
   case fib(N) of
       X when X > 4000000 ->
	   0;
       X when X rem 2 =:= 0 ->
	   X + solve(N+1);
       _X -> 
	   solve(N+1)
   end.

    

    

