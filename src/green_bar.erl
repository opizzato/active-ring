-module (green_bar).
-export ([init/0]).

init () ->
    wx:new(),
    Frame = wxFrame:new(wx:null(), -1, "", [{size, {800, 50}}]),
    put(frame, Frame),
    wxWindow:show(Frame),
    wait (grey). 

wait (Status) ->
    receive
        {get_status, Pid} -> 
            Pid ! Status,
            wait (Status);
        {totals, {_,_,E,_,_,F}} when E > 0 orelse F > 0 -> 
            red (), 
            wait (red);
        {totals, {M,C,0,T,P,0}} when M =:= C andalso T =:= P -> 
            green (), 
            wait (green);
         {totals, _} ->
            grey (),
            wait (grey);
	    stop ->
            bye
    end.

green()-> set_color({56,177,26}).
red()-> set_color({255,0,0}).
grey()-> set_color({179,171,110}).

set_color({R,G,B}) ->
    Frame = get (frame),
    wxWindow: setBackgroundColour (Frame, {R,G,B}),
    wxWindow: refresh (Frame).

