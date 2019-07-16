-module(poc_cowboy_oc).

-export([export_trace/0, spawn_lots/0, trace/0,
	 trace_all/0]).

-define(OUTDIR, "/eflame-export/").

-define(TRACE_OUTFILE, (?OUTDIR) ++ "out.trace").

-define('1_MINUTE', 60 * 1000).

-define(SPAWN_COUNT, 1000).

spawn_lots() ->
    Pids = [spawn_lots_1(V1)
	    || V1 <- lists:seq(1, ?SPAWN_COUNT)],
    lists:foreach(fun (P) ->
			  poc_cowboy_oc_gen_server:gen_primes(P)
		  end,
		  Pids),
    erlang:spawn(fun () ->
			 receive
			   _ -> ok
			   after ?'1_MINUTE' ->
				     io:format("killing all spawned processes~n",
					       []),
				     lists:foreach(fun (P) ->
							   erlang:exit(P, kill)
						   end,
						   Pids)
			 end
		 end).

spawn_lots_1(_) ->
    {ok, Ret} = poc_cowboy_oc_gen_server:start(), Ret.

export_trace() ->
    eflame2:format_trace(?TRACE_OUTFILE,
			 (?OUTDIR) ++ file_timestamp() ++ ".flame").

file_timestamp() ->
    {{Y, Mo, D}, {H, Mi, S}} =
	calendar:now_to_datetime(os:timestamp()),
    io_lib:format("~p-~p-~p-~p-~p-~p",
		  [Y, Mo, D, H, Mi, S]).

trace_all() -> trace(all, 20 * 1000).

trace() ->
    trace(global_and_local_calls_plus_new_procs, 20 * 1000).

trace(Type, Milliseconds) ->
    spawn(fun () ->
		  io:format("Tracing started... outfile: ~p \n",
			    [?TRACE_OUTFILE]),
		  eflame2:write_trace_exp(Type, ?TRACE_OUTFILE, all,
					  Milliseconds),
		  io:format("Tracing finished!\n")
	  end).
