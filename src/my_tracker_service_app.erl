%%%-------------------------------------------------------------------
%% @doc my_tracker_service public API
%% @end
%%%-------------------------------------------------------------------

-module(my_tracker_service_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
        %{"/", cowboy_static, {priv_file, db_access, "static/index.html"}},
            {"/", default_page_h, []},
            {"/package_transferred", package_transfer_page, []}



        ]}
    ]),

    PrivDir = code:priv_dir(my_tracker_service),
    %tls stands for transport layer security
        {ok,_} = cowboy:start_tls(https_listener, [
                                    {port, 443},
                                    {certfile, PrivDir ++ "/ssl/fullchain.pem"},
                                    {keyfile, PrivDir ++ "/ssl/privkey.pem"}],
                                    #{env => #{dispatch => Dispatch}}),

        my_tracker_service_sup:start_link().
stop(_State) ->
    ok.

%% internal functions
