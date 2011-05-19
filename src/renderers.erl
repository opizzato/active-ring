-module (renderers).
-export ([init/1]).

init (Devices) ->
    wait (Devices). 

wait (Devices) ->
    receive
	    stop ->
            forward (stop, Devices),
            bye;
        Message -> 
            forward (Message, Devices),
            wait (Devices)
    end.

forward (Message, Devices) ->
    [ Device ! Message || Device <- Devices].
