% Problem 6
-module(e006).
-export([solve/0]).

calc(X)->
    1/4 * math:pow(X,2) * math:pow(X+1, 2) - 1/6 * X *(X+1) * (2*X+1).

solve() ->
    calc(100).
