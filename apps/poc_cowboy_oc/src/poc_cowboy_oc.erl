-module(poc_cowboy_oc).

-export([export_trace/0,
	 global_and_local_calls_plus_new_procs/0,
	 global_and_local_calls_plus_new_procs/1,
	 spawn_lots/0]).

-define(OUTDIR, "/eflame-export/").
-define(TRACE_OUTFILE, (?OUTDIR) ++ "out.trace").
-define('1_MINUTE',60 * 1000).
-define(SPAWN_COUNT, 1000).

spawn_lots() ->
    Pids = [spawn_lots_1(V1) || V1 <- lists:seq(1, ?SPAWN_COUNT)],
    lists:foreach(fun (P) -> P ! gen_prime end, Pids),
    erlang:spawn(fun () ->
			 receive
			   _ -> ok
			   after ?'1_MINUTE' ->
				     lists:foreach(fun (P) ->
							   erlang:exit(P, kill)
						   end,Pids)
			 end
		 end).

spawn_lots_1(_) ->
    erlang:spawn(poc_cowboy_oc_gen_server, start, []).

export_trace() ->
    eflame2:format_trace(?TRACE_OUTFILE,
			 (?OUTDIR) ++ file_timestamp() ++ ".flame").

file_timestamp() ->
    {{Y, Mo, D}, {H, Mi, S}} =
	calendar:now_to_datetime(os:timestamp()),
    io_lib:format("~p-~p-~p-~p-~p-~p",
		  [Y, Mo, D, H, Mi, S]).

global_and_local_calls_plus_new_procs() ->
    io:format("Tracing started...\n"),
    global_and_local_calls_plus_new_procs(20 * 1000).

global_and_local_calls_plus_new_procs(Milliseconds) ->
    spawn(fun () ->
		  io:format("Tracing started... outfile: ~p \n",
			    [?TRACE_OUTFILE]),
		  eflame2:write_trace_exp(global_calls_plus_new_procs,
					  ?TRACE_OUTFILE, all, Milliseconds),
		  io:format("Tracing finished!\n")
	  end).
