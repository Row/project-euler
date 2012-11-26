-module(e039).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").


solve() ->
    A = ordsets:from_list(lists:seq(1, 1000)),
    B = A,
    C = A,
    P = A,
    propagate(A, B, C).

propagate() ->
    

