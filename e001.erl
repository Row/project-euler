% Problem 1
-module(e001).
-export([solve/0]).

divisable(N) when N rem 3 == 0 ->
    true;
divisable(N) when N rem 5 == 0 ->
    true;
divisable(_) ->
    false.

solve() ->
    lists:sum(lists:filter(fun divisable/1, lists:seq(0,999))).

    

    

