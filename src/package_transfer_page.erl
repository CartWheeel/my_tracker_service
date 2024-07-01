-module(package_transfer_page).
-export([init/2]).

init(Req0, Opts) ->
    {ok, Data, _} = cowboy_req:read_body(Req0),
    case jsx:decode(Data) of
        {ok, DecodedData} ->
            case extract_ids(DecodedData) of
                {ok, Package_ID, Location_ID} ->
                    Result = erpc:call('deliveryman@bl.wheresmypackages.com', business_logic, put_package, [Package_ID, Location_ID]),
                    Encoded_message = jsx:encode(Result),
                    Response = cowboy_req:reply(200, #{<<"content-type">> => <<"application/json">>}, Encoded_message, Req0),
                    {ok, Response, Opts};
                {error, Reason} ->
                    Response = cowboy_req:reply(400, #{<<"content-type">> => <<"application/json">>}, jsx:encode(#{error => "Invalid data format", reason => Reason}), Req0),
                    {ok, Response, Opts}
            end;
        {error, Reason} ->
            Response = cowboy_req:reply(400, #{<<"content-type">> => <<"application/json">>}, jsx:encode(#{error => "Invalid JSON data", reason => Reason}), Req0),
            {ok, Response, Opts}
    end.

%% Helper function to extract Package_ID and Location_ID
extract_ids([{<<"Package_ID">>, Package_ID}, {<<"Location_ID">>, Location_ID}]) ->
    {ok, Package_ID, Location_ID};
extract_ids(_) ->
    {error, "Package_ID and Location_ID not found in JSON data."}.
