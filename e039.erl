-module(e039).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

% A + B + C = P
% A^2 + B^2 = C^2
% C > A
% C > B

solve() ->
    P = 1000,
    A = lists:seq(2, P),
    B = A,
    C = A,
    AB = perms(A, B),
    Sets = [{X, Y, Z} || {X, Y} <- AB, Z <- C,
			 X < Z,
			 Y < Z,
			 pyth_prop(X, Y, Z)
           ],
    solve(Sets, P).

solve(Sets, P) ->
    solve(Sets, P, {P + 1, 0}).

solve(_Sets, 1, Max) ->
    Max; 
solve(Sets , P, Max = {_MaxP, MaxLength}) ->
    LengthSolution = length(solve1(Sets, P)),
    case MaxLength < LengthSolution of
	true ->
	    solve(Sets, P - 1, {P, LengthSolution});
	false ->
	    solve(Sets, P - 1, Max)
    end.

    
solve1(Sets, P) ->
    [{X, Y, Z} || {X, Y, Z} <- Sets,
		   sum_prop(X, Y, Z, P)
     ].

perms(A, B) -> 
    [{X, Y} || X <- A, Y <- B, X < Y].

sum_prop(A, B, C, P) ->
    A + B + C =:= P.

pyth_prop(A, B, C) ->
    A * A + B * B =:= C * C.
