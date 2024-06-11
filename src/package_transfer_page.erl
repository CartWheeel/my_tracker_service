%% @doc Hello world handler.
-module(default_page_h).

-export([init/2]).

init(Req0, Opts) ->
        Req = cowboy_req:reply(200, #{
                <<"content-type">> => <<"text/plain">>
        }, "Hello world! This is exciting!", Req0),
        {ok, Req, Opts}.