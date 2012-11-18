-module(e036).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

solve() ->
	solve(1000000 - 1).

solve(N) ->
	solve(N, 0).

solve(1, Acc) ->
	Acc + 1;
solve(N, Acc) ->
	case dec_reverse(N) =:= N andalso N =:= binary_reverse(N) band N of
		true ->
			solve(N - 2, Acc + N);
		false ->
			solve(N - 2, Acc)
	end.


dec_reverse(N) ->
	dec_reverse(N, 0).

dec_reverse(0, R) ->
	R;
dec_reverse(N, R) ->
	dec_reverse(N div 10, (R * 10) + (N rem 10)).


binary_reverse(N) ->
	binary_reverse(N, 0).

binary_reverse(0, R) ->
	R;
binary_reverse(N, R) ->
	Bit = N band 1,
	binary_reverse(N bsr 1, (R bsl 1) bor Bit).


% test
binary_reverse_test() ->
	?assertEqual(5, binary_reverse(5)),
	?assertEqual(13, binary_reverse(11)).