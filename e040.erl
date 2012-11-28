-module(e040).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

solve() ->
    solve(0, 10, 1).

solve(_SumDigits, 10000000, _N) ->
    1;
solve(SumDigits, NextSum, N) ->
    NewSum = SumDigits + length_int(N),
    case NewSum >= NextSum of
	true ->
	    Term = take_nth(N, NewSum - NextSum + 1),
	    Term * solve(NewSum, NextSum * 10, N + 1);
	false ->
	    solve(NewSum, NextSum, N + 1)
    end.
    
length_int(N) ->
    length_int(N, 1).

length_int(N, L) when N < 10 ->
    L;
length_int(N, L) ->
    length_int(N div 10, L + 1).


take_nth(N, Num) ->
    N div round(math:pow(10, Num - 1)) rem 10.


length_int_test() ->
    ?assertEqual(1, length_int(1)),
    ?assertEqual(2, length_int(10)),
    ?assertEqual(3, length_int(123)),
    ?assertEqual(3, length_int(103)).


take_nth_test() ->
    ?assertEqual(0, take_nth(10, 1)),
    ?assertEqual(1, take_nth(10, 2)),
    ?assertEqual(2, take_nth(1234, 3)),
    ?assertEqual(1, take_nth(1234, 4)).





