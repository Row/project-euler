-module(e025).

-export([solve/0, pow/2]).

solve() ->
    fib(1000).

pow(X, N) -> 
    pow(X, N, 1).
pow(_, 0, P) -> 
    P;
pow(X, N, A) -> 
    pow(X, N-1, A*X).

fib(Length) ->
    fib(pow(10,Length - 1), 0, 0, 1).

fib(Length, N, Result, _Next) when Result div Length >= 1 ->
    {N, Result}; 
fib(Length, N, Result, Next) ->
    fib(Length, N + 1, Next, Result + Next).

    

    
