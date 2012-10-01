-module(e015).
-export([solve/0]).

solve() ->
    grid(15, 15).

grid(0, 0) ->
    1;
grid(X, 0) ->
    grid(X - 1, 0); % Only left
grid(0, Y) ->
    grid(0, Y - 1); % Only up
grid(X, Y) ->
      grid(X - 1, Y)     % Left 
    + grid(X, Y - 1).	 % Up
    
