-module(e015).
-export([solve/0]).
-define(WIDTH, 20).

solve() ->
    A = array:new([{size,(?WIDTH+1) * (?WIDTH+1) },{fixed,true},{default,-1}]),
    solve(A, 0, ?WIDTH).

solve(A, X, W) when X > W ->
    matrix_get(A, X-1, X-1);
solve(A, X, W) ->
    {B, R} = grid(A, X, X),
    solve(B, X + 1, W).

matrix_get(A, Col, Row)->
    array:get(Col + Row * ?WIDTH, A).

matrix_set(A, Col, Row, Val)->
    array:set(Col + Row * ?WIDTH, Val, A).

grid(A, 0, 0) ->
    {A, 1};
grid(A, X, 0) ->
    grid(A, X - 1, 0); % Only left
grid(A, 0, Y) ->
    grid(A, 0, Y - 1); % Only up
grid(A, X, Y) ->
    V = matrix_get(A, X, Y),
    case V > -1 of
	true -> 
	    {A, V};
	false ->	    
	    {B, R1} = grid(A, X - 1, Y),      % Left 
	    {C, R2} = grid(B, X, Y - 1),      % Up
	    {matrix_set(C, X, Y, R1 + R2), R1 + R2}
    end.
