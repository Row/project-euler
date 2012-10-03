-module(e022).
-export([solve/0]).

% Initail file reading taken from http://www.trapexit.org/Read_File_to_List 
read_lines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
    case io:get_line(Device, "") of
        eof  -> file:close(Device), Accum;
        Line -> get_all_lines(Device, Accum ++ [Line])
    end.

% Function from Erlang and OTP in Action
args_to_terms(RawArgs) ->
    {ok, Toks, _Line} = erl_scan:string("[" ++ RawArgs ++ "]. ", 1),
    {ok, Args} = erl_parse:parse_term(Toks),
    Args.

alphabetical_value([]) ->
    0;
alphabetical_value([H|T]) ->
    H - 64 + alphabetical_value(T).

total_score(Names) ->
    total_score(Names, 1).
		      
total_score([], _N) ->
    0;
total_score([Name|T], N) ->
    alphabetical_value(Name) * N + total_score(T, N + 1).

solve() ->
    Names = lists:sort(args_to_terms(lists:nth(1 ,read_lines("e022-names.txt")))),
    total_score(Names).
