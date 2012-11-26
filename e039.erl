-module(e039).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

% A + B + C = P
% A^2 + B^2 = C^2
% C > A
% C > B

solve() ->
    P = 1000;

solve(0) ->
    0;
solve(P) ->
    max(n(P), solve(P - 1)).


n(P) ->
    n(P - 1, P - 1, P, P).
n(0, 0, C, P) ->
    n(A - 1, C - 1, C, P);
n(A, 0, C, P) ->
    n(A - 1, C - 1, C, P);
n(A, B, C, P) when A + B + C =/= P ->

n(A, B, C, P)

