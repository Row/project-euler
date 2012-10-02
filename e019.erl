-module(e019).
-export([solve/0]).

solve() ->
    count_sundays_on_the_first(1,1,1901,1,1,2001).

is_leap_year(Y) when Y rem 4 =:= 0 andalso Y rem 100 =/= 0 ->
    true;
is_leap_year(Y) when Y rem 100 =:= 0 andalso Y rem 400 =:= 0 ->
    true;
is_leap_year(_Y) ->
    false.

days_in_month(_Y, 1) ->
    31;
days_in_month(Y, 2) ->
    case is_leap_year(Y) of
	true  -> 29;
	false -> 28
    end;
days_in_month(_Y, 3) ->
    31;
days_in_month(_Y, 4) ->
    30;
days_in_month(_Y, 5) ->
    31;
days_in_month(_Y, 6) ->
    30;
days_in_month(_Y, 7) ->
    31;
days_in_month(_Y, 8) ->
    31;
days_in_month(_Y, 9) ->
    30;
days_in_month(_Y, 10) ->
    31;
days_in_month(_Y, 11) ->
    30;
days_in_month(_Y, 12) ->
    31.

% Known date and weekday
get_weekday_of_date(1, 1, 1900) ->
    0;
get_weekday_of_date(1, 1, Y) ->
    (1 + get_weekday_of_date(31, 12, Y - 1)) rem 7;
get_weekday_of_date(1, M, Y) ->
    (1 + get_weekday_of_date(days_in_month(Y, M - 1), M - 1, Y)) rem 7;
get_weekday_of_date(D, M, Y) ->
    (1 + get_weekday_of_date(D - 1, M, Y)) rem 7.

count_sundays_on_the_first(D, M, Y, D1, M1, Y1) ->
    count_sundays_on_the_first(D, M, Y, D1, M1, Y1, get_weekday_of_date(D, M, Y)).

count_sundays_on_the_first(D, M, Y,  D, M, Y, _W) ->
    0;
count_sundays_on_the_first(1, M, Y,  D1, M1, Y1, 6) ->
    1 + count_sundays_on_the_first(2, M, Y,  D1, M1, Y1, 0);
count_sundays_on_the_first(D, M, Y,  D1, M1, Y1, W) ->
    case days_in_month(Y, M) =< D andalso M =:= 12 of
	true  -> count_sundays_on_the_first(1, 1, Y+1,  D1, M1, Y1, (W+1) rem 7);	
	false -> 
	    case  days_in_month(Y, M) =< D of
		true  -> count_sundays_on_the_first(1, M + 1, Y, D1, M1, Y1, (W+1) rem 7);
		false -> count_sundays_on_the_first(D + 1, M, Y, D1, M1, Y1, (W+1) rem 7)
	    end
    end.
