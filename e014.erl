-module(e014).
-export([solve/0]).

% n  n/2 (n is even)
% n  3n + 1 (n is odd)
% Note to self, another solution would be dynamic programming, by caching the solution

gen_seq(1) ->
    1;
gen_seq(N) when N rem 2 =:= 0 ->
    1+gen_seq(N div 2);
gen_seq(N) when N rem 2 =:= 1 ->
    1+gen_seq(3 * N + 1).


solve() ->
    Start = 999999,
    solve(0, 0, Start).

solve(_BestResult, BestStart, 1) ->
    BestStart;
solve(BestResult, BestStart, I) ->
    R = gen_seq(I),
    case R > BestResult of 
	true -> 
	    solve(R, I, I-1);
	false ->
	    solve(BestResult, BestStart, I - 1)
    end.
