-module(e032).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

perms([]) -> 
	[[]];
perms(L)  -> 
	[[H|T] || H <- L, T <- perms(L--[H])].


solve() ->
	{ok, Reg} = re:compile("^[1-9]+[^1-9][1-9]+=[1-9]+$"),
	Perms = lists:filter(
		fun (X) -> 
			case re:run(X, Reg) of
				{match, _} -> true;
				_ 		   -> false
			end
		end, perms("123456789*=")),
	lists:sum(lists:usort(evaluate(Perms, []))).

evaluate([], Acc) ->
	Acc;
evaluate([ H | T ], Acc) ->
    case re:run(H, "^([1-9]+)[^1-9]([1-9]+)=([1-9]+)$", [{capture,[1, 2, 3], list}]) of
	{match, [A, B, C]} ->
	    case list_to_integer(A) * list_to_integer	(B) =:= list_to_integer(C) of
	    	true ->
	    		evaluate(T, [list_to_integer(C) |Acc]);
	    	false ->
	    		evaluate(T, Acc)
	    end;
	nomatch ->
	    error
    end.

% Test
hey_test() ->
	?assertMatch([7254], evaluate(["39*186=7254"], [])).