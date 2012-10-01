-module(e017).
-export([solve/0]).

dec(2) ->
    "twenty";
dec(3) ->
    "thirty";
dec(4) ->
    "forty";
dec(5) ->
    "fifty";
dec(6) ->
    "sixty";
dec(7) ->
    "seventy";
dec(8) ->
    "eighty";
dec(9) ->
    "ninety".

num(1) ->
    "one";
num(2) ->
    "two";
num(3) ->
    "three";
num(4) ->
    "four";
num(5) ->
    "five";
num(6) ->
    "six";
num(7) ->
    "seven";
num(8) ->
    "eight";
num(9) ->
    "nine";
num(0) ->
    "";
num(10)->
    "ten";
num(11) ->
    "eleven";
num(12) ->
    "twelve";
num(13) ->
    "thirteen";
num(14) ->
    "fourteen";
num(15) ->
    "fifteen";
num(16) ->
    "sixteen";
num(17) ->
    "seventeen";
num(18) ->
    "eighteen";
num(19) ->
    "nineteen".

parse(N) when N >= 1000 ->
    num(N div 1000) ++ "thousand" ++ parse(N rem 1000);
parse(N) when N >= 100 andalso N rem 100 =:= 0 ->
    num(N div 100) ++ "hundred";
parse(N) when N >= 100 ->
    num(N div 100) ++ "hundred" ++ "and" ++ parse(N rem 100);
parse(N) when N >= 20 ->
    dec(N div 10) ++ num(N rem 10);
parse(N) when N < 20 ->
    num(N).
    
solve() ->
    string:len(solve(1000)).
solve(0) ->
    "";
solve(N)->
    parse(N)++solve(N-1).
