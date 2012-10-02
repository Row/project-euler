-module(e020).
-export([solve/0]).

% Tail recursive
factorial(1, Product) ->
    Product;
factorial(N, Product) ->
    factorial(N - 1, Product * N).

sum_digits(N, Sum) when N < 10 ->
    Sum + N;
sum_digits(N, Sum) ->
    sum_digits(N div 10, (N rem 10) + Sum).

solve() ->
    sum_digits(factorial(100, 1), 0).
