-module(e028).
-export([solve/0]).

solve() ->
	walk(1, 3, 1001 * 1001).

walk(N, _LayerLength, N) ->
	1;
walk(N, LayerLength, TargetN) ->
	Step = LayerLength - 1,
	N + Step +
	N + Step * 2 +
	N + Step * 3 +
	N + Step * 4 +
	walk(N + Step * 4, LayerLength + 2, TargetN).