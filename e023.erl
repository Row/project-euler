-module(e023).

-export([solve/0]).

divisors(N) ->
    divisors(N, N - 1).
divisors(_N, 1) ->
    [1];
divisors(N, D) when N rem D =:= 0 ->
    [D|divisors(N, D - 1)];
divisors(N, D) ->
    divisors(N, D - 1).

proper_divisors(D, N) ->    
    [1|[X || X <- D, lists:member(N div X, D)]]. 

d(N) ->
   lists:sum(proper_divisors(divisors(N), N)).

is_abundant(N) ->
    N < d(N).

solve() ->
    Limit = 28123,
    Sequence = lists:seq(2, Limit),
    io:format("Sequence done~n"),
    Abuntants = [X || X <-  Sequence, is_abundant(X)],
    io:format("Abuntants done~n"),
    AbuntantSumsUnique = [(X + Y) ||  X <- Abuntants, Y <- Abuntants, X < Y andalso (X + Y) =< Limit],
    io:format("Abuntant sums done L: ~p Last: ~p~n",[length(AbuntantSumsUnique), lists:last(AbuntantSumsUnique)]),
    AbuntantSums  = lists:usort(AbuntantSumsUnique ++ [(X + X) ||  X <- Abuntants, (X + X) =< Limit]),
    io:format("Abuntant sums done L: ~p Last: ~p~n",[length(AbuntantSums), lists:last(AbuntantSums)]),
    ResultSequence = Sequence -- AbuntantSums,
    {lists:sum(ResultSequence) + 1, ResultSequence}.
