%%%-------------------------------------------------------------------
%% @doc my_tracker_service public API
%% @end
%%%-------------------------------------------------------------------

-module(my_tracker_service_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
        Dispatch = cowboy_router:compile([
            {'_', [
                {"/", defualt_page_h, []}
            ]}
        ]),
        cowboy:start_clear(
            my_http_listener,
            [{port, 80}],
            #{env => #{dispatch => Dispatch}}
        ),
        my_tracker_service_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
