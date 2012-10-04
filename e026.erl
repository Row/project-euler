-module(e026a).

-export([solve/0]).


pow(X, N) -> 
    pow(X, N, 1).
pow(_, 0, P) -> 
    P;
pow(X, N, A) -> 
    pow(X, N-1, A*X).

get_length([L]) ->
    case re:run(L, "^(.)\\1+$",[{capture,[1],list}]) of
	{match, _M} ->
	    1;
	nomatch ->
	    length(L)
    end.

longest_rec(N) ->
    NumberList = integer_to_list(N),
    case re:run(NumberList, "(.+?)\\1",[{capture,[1],list}]) of
	{match, L} ->
	    get_length(L);
	nomatch ->
	    0
    end.

% pow(10, N * 2) because cycle can not be longer than N
collect_results(0) ->
    [];
collect_results(N) ->
    [{longest_rec(pow(10, N * 2) div N), N} | collect_results(N - 1)].
    
solve() ->
    lists:max(collect_results(999)).
