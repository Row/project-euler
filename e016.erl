-module(e016).
-export([solve/0]).

solve() ->
    solve(round(math:pow(2,1000)), 0).

solve(N, S) when N < 10 ->
    S+N;
solve(N, S) ->
    solve(N div 10, N rem 10 + S).

