-module(poc_cowboy_oc_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Pid} = poc_cowboy_oc_sup:start_link(),
    Routes = [{'_', [{"/", poc_cowboy_oc_root, []}]}],
    TransOpts = [{ip, {0, 0, 0, 0}}, {port, 4000}],
    ProtoOpts = #{env =>
		      #{dispatch => cowboy_router:compile(Routes)}},
    {ok, _} = cowboy:start_clear(poc_cowboy_oc, TransOpts,
				 ProtoOpts),
    {ok, Pid}.

stop(_State) -> ok.
