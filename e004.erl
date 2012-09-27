-module(e004).
-export([solve/0]).

is_palindrome_integer(N) ->
    L = integer_to_list(N),
    L =:= lists:reverse(L).

find_palindrome(N, M) ->
    io:format("~p, ~p~n",[N, M]),
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

%999*999
%999*998
%999*997

%998*998
%998*997
%998*996

%997*997
%997*996
%997*995

%996*996
%996*
