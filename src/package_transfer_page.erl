-module(package_transfer_page).

-export([init/2]).

init(Req0, Opts) ->
        {ok,Data,_} = cowboy_req:read_body(Req0),
        % it is expected that the data consists of one quoted-string name
        % in an array.
        
        % [{<<"Package_ID">>,Package_ID},{<<"Location_ID">>,Location_ID}]  = jsx:decode(Data),
        #{<<"location_id">> := Location_ID, <<"package_id">> := Package_ID} = jsx:decode(Data),

        % test [<<"35">>,<<"14">>] = [Package_ID,Location_ID],
        erpc:cast('deliveryman@bl.wheresmypackages.com', business_logic, put_package, [Package_ID,Location_ID]), 
        
        %get_friends_server:get_friends_of(Package_ID) of
                %         {error,notfound} -> "no such person";
                %         Friends -> Friends
                % end,
                
        % Encoded_message = jsx:encode(Result),
        %io:format("~p~n",[get_friends_server:get_friends_of(Name)]),

        Response = cowboy_req:reply(200,
                #{<<"content-type">> => <<"text/json">>},
                "", Req0),
        {ok, Response, Opts}.




