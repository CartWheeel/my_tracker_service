%%%-------------------------------------------------------------------
%% @doc my_tracker_service public API
%% @end
%%%-------------------------------------------------------------------

-module(my_tracker_service_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    my_tracker_service_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
