-module(e033).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").


solve() ->
	{A, B} = multiply_fractions(solve(99, 99)),
	Gcd = gcd(A, B),
	{A div Gcd, B div Gcd}.

solve(_, 11) ->
	[];
solve(10, B) ->
	solve(B - 2, B - 1);
solve(A, B) ->
	case is_curious(A, B) of
		true ->
			[{A, B} | solve(A - 1, B)];
		false ->
			solve(A - 1, B)
	end.


gcd(A, A) ->
	A;
gcd(A, B) when B < A ->
	gcd(A - B, B);
gcd(A, B) when A < B ->
	gcd(A, B - A).


multiply_fractions(L) ->
	multiply_fractions(L, {1, 1}).

multiply_fractions([], Res) ->
	Res;
multiply_fractions([{A, B}|T], {R1, R2}) ->
	multiply_fractions(T, {R1 * A, R2 * B}).


is_curious(A, B) when A >= B ->
	false;
is_curious(A, B) when A rem 10 =:= 0 andalso B rem 10 =:= 0 ->
	false;
is_curious(A, B) ->
	is_curious(A, integer_to_list(A), B, integer_to_list(B)).


is_curious(_, _, _, [_B1, 48]) ->
	false;
is_curious(A, [A1, _A2], B, [B1, A1]) ->
	A / B =:= (A rem 10) / (B div 10);
is_curious(A, [A1, A2], B, [A2, B2]) ->
	A / B =:= (A div 10) / (B rem 10);
is_curious(A, [A1, A2], B, [A1, B2]) ->
	A / B =:= (A rem 10) / (B rem 10);
is_curious(A, [A1, A2], B, [B1, A2]) ->
	A / B =:= (A div 10) / (B div 10);
is_curious(_, _, _, _) ->
	false.

% test
curious_test() ->
	?assert(not is_curious(88, 9)),
	?assert(not is_curious(11, 98)),
	?assert(is_curious(49, 98)),
	?assert(not is_curious(89, 90)).