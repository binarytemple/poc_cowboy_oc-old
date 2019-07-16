-module(poc_cowboy_oc_gen_server).

-behaviour(gen_server).

-export([code_change/3, handle_call/3, handle_cast/2,
	 handle_info/2, init/1, terminate/2]).

-export([sleep/1, start/0]).

start() -> gen_server:start(?MODULE, [], []).

sleep(pid) -> gen_server:call(pid, sleep).

init(_Args) -> {ok, []}.

handle_call(sleep, _From, State) ->
    {reply, State, State}.

handle_cast(_Request, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.
