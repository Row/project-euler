% Problem 5
-module(e005).
-export([solve/0]).

cat(_N, []) ->
    true;
cat(N, [H|_T]) when N rem H =/= 0 ->
    false;
cat(N, [_H|T]) ->
    cat(N, T).

dog(Rainbow, Unicorn) ->
    case cat(Rainbow, Unicorn) of
	true ->
	    Rainbow;
	false ->
	    dog(Rainbow+1, Unicorn)
    end.

solve() ->
    dog(1, lists:seq(3, 20)).
