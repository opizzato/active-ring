-module(renderers_test).
-test (exports).
-export ([renderers_forwards_a_message_test/0]).

renderers_forwards_a_message_test() ->
    Printer = self(),
    BarreVerte = self(),
    Renderers = spawn_link (renderers, init, [[Printer, BarreVerte]]),
    Renderers ! message,
    ok = receive message -> ok after 1000 -> timeout end,
    ok = receive message -> ok after 1000 -> timeout end.

