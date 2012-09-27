% Problem 4
-module(e004).
-export([solve/0]).

is_palindrome_integer(N) ->
    L = integer_to_list(N),
    L =:= lists:reverse(L).

find_palindrome(N, M) ->
    Product = N * M,
    case is_palindrome_integer(Product) of
	true ->
	    Product;
	false ->
	    case M < 800 of
		true -> 
		    find_palindrome(N - 1, N - 1);
		false ->
		    find_palindrome(N, M - 1)
	    end		
    end.
solve() ->
    find_palindrome(999, 999).
