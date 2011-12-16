-module(green_bar_test).
-test (exports).
-export ([grey_by_default/0]).
-export ([grey_during_execution_without_error/0]).
-export ([red_when_test_failure/0]).
-export ([yellow_when_compilation_failure/0]).
-export ([green_when_ended_and_no_errors/0]).

grey_by_default() ->
    B = bar(),
    grey = status(B).

grey_during_execution_without_error() ->
    B = bar(),
    B ! {totals, {4, 2, 0, 0, 0, 0}},
    grey = status(B),
    B ! {totals, {4, 4, 0, 3, 1, 0}},
    grey = status(B).

red_when_test_failure() ->
    B = bar(),
    B ! {totals, {4, 4, 0, 2, 0, 1}},
    red = status(B).
    
yellow_when_compilation_failure() ->
    B = bar(),
    B ! {totals, {4, 2, 1, 0, 0, 0}},
    yellow = status(B),
    B ! {totals, {4, 3, 1, 2, 1, 0}},
    yellow = status(B).

green_when_ended_and_no_errors() ->
    B = bar(),
    B ! {totals, {4, 4, 0, 2, 2, 0}},
    green = status(B).

    
bar() ->
    spawn_link(green_bar, init, []).

status(B) ->
    B ! {get_status, self()},
    receive Status -> Status after 1000 -> timeout end.

