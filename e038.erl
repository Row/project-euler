-module(e038).
-export([solve/0]).
-include_lib("eunit/include/eunit.hrl").



%% 
%%
%%
perms([]) -> 
    [[]];
perms(L)  -> 
    [[H|T] || H <- L, T <- perms(L--[H])].

solve() ->
    Candidates = [[$9 | L] || L <- perms("87654321")],
    solve(Candidates).

solve([]) ->
    no_solution;
solve([Candidate|Candidates]) ->
    case is_sol(Candidate) of
	true ->
	    Candidate;
	false ->
	    io:format("~p~n", [Candidate]),
	    solve(Candidates)
    end.

is_sol(Candidate) ->
    is_sol(Candidate, "", "", 2, 2).

is_sol(Candidate, Candidate, _Term, 0, _NU) ->
    true;
is_sol(Candidate, _PartSol, Candidate, _N, _NU) ->
    false;
is_sol(_Candidate, _PartSol, _Term, 0, _NU) ->
    false;
is_sol(_Candidate, _PartSol, _Term, _N, NU) when NU > 20 ->
    false;
is_sol(_Candidate, PartSol, _Term, _N, _NU) when length(PartSol) >= 9 ->
    false;
is_sol(Candidate, _PartSol, "", _N, NU) ->
    Term = take_term(Candidate, ""),
    is_sol(Candidate, "", Term, NU, NU);
is_sol(Candidate, _PartSol, Term, 0, NU) ->
    NewTerm = take_term(Candidate, Term),
    is_sol(Candidate, "", NewTerm, NU + 1, NU + 1);
is_sol(Candidate, PartSol, Term, N, NU) ->
    case lists:suffix(PartSol, Candidate) of
	true ->
	    NewPartSol = list_product(Term, N) ++ PartSol,
	    is_sol(Candidate, NewPartSol, Term, N - 1, NU);
	false ->
	    case is_sol(Candidate, "", Term, NU + 1, NU + 1) of
		true ->
		    true;
		false ->
		    NewTerm = take_term(Candidate, Term),
		    is_sol(Candidate, "", NewTerm, NU, NU)
	    end
    end.	     



list_product(Term, N) ->
    Product = list_to_integer(Term) * N,
    integer_to_list(Product).

take_term(Candidate, CurrentTerm) ->
    lists:sublist(Candidate, length(CurrentTerm) + 1).
				    

is_sol_test() ->
    ?assert(is_sol("918273645")),
    ?assert(not is_sol("918237645")).
    
