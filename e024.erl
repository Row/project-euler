-module(e024).

-export([solve/0]).

perms([]) -> 
    [[]];
perms(L)  -> 
    [[H|T] || H <- L, T <- perms(L--[H])].

solve() ->
    L = perms([0, 1, 2, 3, 4, 5, 6, 7, 8 ,9]),
    lists:nth(1000000, L).
