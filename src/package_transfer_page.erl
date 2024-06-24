%% @doc Hello world handler.
-module(package_transfer_page).

-export([init/2]).

init(Req0, Opts) ->
        Req = cowboy_req:reply(200, #{
                <<"content-type">> => <<"text/plain">>
        }, "This is incredible! I finally got it to work!", Req0),
        {ok, Req, Opts}.