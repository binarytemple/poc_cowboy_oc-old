-module(poc_cowboy_oc_root).

-export([init/2]).

init(Req0, State) -> 
    Req = cowboy_req:reply(200, #{                                                                                                             
        <<"content-type">> => <<"text/plain">>                                                                                                 
    }, <<"Hello World!">>, Req0),                                                                                                              
    {ok, Req, State}.  
