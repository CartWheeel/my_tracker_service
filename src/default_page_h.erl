%% @doc Hello world handler.
-module(default_page_h).

-export([init/2]).

init(Req0, Opts) ->
        Req = cowboy_req:reply(200, #{
                <<"content-type">> => <<"text/plain">>
        }, "HELLO WORLD! Did this work?", Req0),
        {ok, Req, Opts}.