-module(e067).
-export([solve/0]).

% Initail file reading taken from http://www.trapexit.org/Read_File_to_List 
read_lines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
    case io:get_line(Device, "") of
        eof  -> file:close(Device), Accum;
        Line -> get_all_lines(Device, Accum ++ [parse_line(Line)])
    end.


parse_line(String) ->
    [ element(1, string:to_integer(X)) || X <- string:tokens(string:substr(String, 1, string:len(String) - 1), " ")].


solve() ->
    T = read_lines("e067-triangle.txt"),
    solve_pyr_init(T).

solve_pyr_init([L | P]) ->
	solve_pyr(L, P).

solve_pyr(Ar, [Pr | []]) ->
	lists:max(solve_row_init(Ar, Pr));
solve_pyr(Ar, [Pr | P]) ->
	L = solve_row_init(Ar, Pr),
	solve_pyr(L, P).

solve_row_init([A1 | T1], [H2 | T2]) ->
    [A1 + H2 | solve_row([A1 | T1], T2)].

solve_row([A1, A2 | T1], [H2 | T2]) ->
    [max(A1, A2) + H2 | solve_row([A2 | T1], T2)];
solve_row([A1 | []], [H2 | []]) ->
	[A1 + H2].
