-module(e038).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").

perms([]) -> 
    [[]];
perms(L)  -> 
    [[H|T] || H <- L, T <- perms(L--[H])].

solve() ->
    Candidates = [ 900000000 + list_to_integer(L) || L <- perms("87654321")],
    solve(Candidates).

solve([]) ->
    no_solution;
solve([Candidate|Candidates]) ->	     
   case is_solution(Candidate) of
       true ->
	   Candidate;
       false ->
	   io:format("~p~n", [Candidate]),
	   solve(Candidates)
   end.

is_solution(Candidate) ->
    is_solution(Candidate, 9, Candidate, 9).

is_solution(_Candidate, _Term, 0, _N) ->
    true;
is_solution(Candidate, Term, _Rest, 0) ->
    is_solution(Candidate, concat_one(Candidate, Term), Candidate, 20);
is_solution(_Candidate, Term, _Rest, _N) when  Term > 1000 ->
    false;
is_solution(_Candidate, _Term, Rest, _N) when Rest < 0 ->
    false;
is_solution(Candidate, Term, Rest, N) ->
    Product = N * Term,
    io:format("~p, ~p, ~p, ~p, ~p~n", [Candidate, Term, Product, Rest, N]),
    case check_suffix(Rest, Product) of
       false ->
	    is_solution(Candidate, Term, Candidate, N - 1);
       NewRest ->
	    is_solution(Candidate, Term, NewRest, N)
   end.

check_suffix(Rest, 0) ->
    Rest;
check_suffix(Rest, Term) ->
    case Rest rem 10 =:= Term rem 10 of
	true ->
	    check_suffix(Rest div 10, Term div 10);
	false ->
	    false
    end.

concat_one(Candidate, Term) ->
    concat_nth(Candidate, 
	       Term, 
	       length_int(Candidate) - length_int(Term)).

concat_nth(Candidate, Term, 1) ->
    Term * 10 + Candidate rem 10;
concat_nth(Candidate, Term, N) ->
    concat_nth(Candidate div 10, Term, N - 1).


length_int(N) ->
    length_int(N, 1).

length_int(N, L) when N < 10 ->
    L;
length_int(N, L) ->
    length_int(N div 10, L + 1).



%% Tests
length_int_test() ->
    ?assertEqual(3, length_int(456)),
    ?assertEqual(1, length_int(4)),    
    ?assertEqual(1, length_int(0)).



check_term_test() ->
    ?assertEqual(123, check_suffix(123456, 456)),
    ?assertEqual(false, check_suffix(123456, 486)) .
				    
concat_one_test() ->
    ?assertEqual(987, concat_one(987, 98)),
    ?assertEqual(98, concat_one(9876, 9)),
    ?assertEqual(2, concat_one(12, 0)),
    ?assertEqual(22, concat_one(12, 2)).

is_sol_test() ->
    ?assert(is_solution(918273645)),
    ?assert(not is_solution(918237645)).
    
