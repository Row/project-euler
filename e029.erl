-module(e029).
-export([solve/0]).

solve() ->
	length(lists:usort(calculate_permutations(100))).


calculate_permutations(N) ->
	calculate_permutations(N, N, N).

calculate_permutations(_, 1, _) ->
	[];
calculate_permutations(1, B, N) ->
	calculate_permutations(N, B - 1, N);
calculate_permutations(A, B, N) ->
	[round(math:pow(A, B)) | calculate_permutations(A - 1, B, N)].