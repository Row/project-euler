-module(e039).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

% A + B + C = P
% A^2 + B^2 = C^2
% C > A
% C > B

solve() ->
    solve(1000).

solve(1) ->
    0; 
solve(P) ->
    A = lists:seq(2, P),
    B = A,
    C = A,
    max(length(solve(A, B, C, P)), solve(P - 1)).

    
solve(A, B, C, P) ->
    Sets = [{X, Y, Z} || X <- A, Y <- B, Z <- C,
            X < Z,
            Y < Z,
            X < Y,
            sum_prop(X, Y, Z, P),
            pyth_prop(X, Y, Z)
           ],
    io:format("~p, ~p~n", [P, Sets]),
    Sets.

sum_prop(A, B, C, P) ->
    A + B + C =:= P.

pyth_prop(A, B, C) ->
    A*A + B*B =:= C*C.