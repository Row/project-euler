-module(e027).

-export([solve/0]).
% create lists with inital values a = -1000 to 1000, b = positive primes < 1000
% first find all primes below 1000 n = 0, this is possible values of b
% second find all primes for n = 1, eleminate values of a which is in b.

is_prime(P) when P < 2 ->
    false;
is_prime(P) ->
    R = round(math:sqrt(P)),
    is_prime(P, R).

is_prime(_P, 1) ->
    true;
is_prime(P, N) when P rem N =:= 0 ->
    false;
is_prime(P, N) ->
    is_prime(P, N - 1).

primes_below(2) ->
    [2]; 
primes_below(N) ->
    case is_prime(N) of
        true -> 
            [N|primes_below(N - 1)];
        false ->
            primes_below(N - 1)
    end.

quad_form(A, B, N) ->
    (N * N) + (A * N) + B.

can_generate(A, B, N) ->
    is_prime(quad_form(A, B, N)).

solve() ->
    B = lists:seq(-999, 999), % since 0^2 + a*n + b = b => b must be prime
    A = lists:seq(-999, 999),
solve(A, B).

solve(A, B) ->
    solve(A, B, 0, [], []).

solve([A], [B], N, _, _) -> % solution
    io:format("~p) ~p*~p + ~p*~p + ~p~n", [N, N, N, A, N, B]),
    A * B;
solve([], _B, N, Agen, Bgen) ->
    io:format("~p) ~p~n", [N, Agen]),
    solve(Agen, lists:usort(Bgen), N + 1, [], []);
solve([A|AT], B, N, Agen, Bgen) ->
    NewBgen = find_combinations(A, B, N),
    %io:format("~p~n", [NewBgen]),
    case length(NewBgen) > 0 of
        true ->
            solve(AT, B, N, [A|Agen], NewBgen ++ Bgen);
        false ->
            solve(AT, B, N, Agen, Bgen)
    end.
    
% A is integer
% B is list
find_combinations(A, B, N) ->
    find_combinations(A, B, N, []).

find_combinations(_A, [], _N, Acc) ->
    Acc;
find_combinations(A, [B|BT], N, Acc) ->
    case can_generate(A, B, N) of
        true -> 
            find_combinations(A, BT, N, [B | Acc]);
        false -> 
            find_combinations(A, BT, N, Acc)
    end.
    
    


