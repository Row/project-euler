-module(e027).

-export([solve/0]).

%% True if P is a prime
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

% Generates a list of primes below N
primes_below(2) ->
    [2]; 
primes_below(N) ->
    case is_prime(N) of
        true -> 
            [N|primes_below(N - 1)];
        false ->
            primes_below(N - 1)
    end.

% The quadratic formula
quad_form(A, B, N) ->
    (N * N) + (A * N) + B.

% A, B can generate prime for N
can_generate(A, B, N) ->
    is_prime(quad_form(A, B, N)).

% Finds the longest prime sequence for A in combination of B
find_longest(A, B, N) ->
    NewB = find_combinations(A, B, N),
    case NewB of
        [] -> 
            {N - 1, A, B}; % Can not generate with N
        _ -> 
            find_longest(A, NewB, N + 1)
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

max_result(R1 = {N1, _, _}, {N2, _, _}) when N1 > N2 ->
    R1;
max_result(_R1, R2) ->
    R2.

solve() ->
    B = primes_below(1000), % since 0^2 + a*n + b = b => b must be prime
    A = lists:seq(-999, 999),
    {N, ARes, [BRes]} = solve(A, B, {0, bogus,  bogus}),
    {N, ARes, BRes, ARes * BRes}.

solve([], _B, Acc) ->
    Acc;
solve([A | AT], B, Acc) ->
    Res = find_longest(A, B, 0),
    solve(AT, B, max_result(Res, Acc)). 
