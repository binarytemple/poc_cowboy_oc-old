-module(poc_cowboy_oc).

-export([export_trace/0,
	 run_eflame_global_calls_plus_new_procs/0,
	 run_eflame_global_calls_plus_new_procs/1,
	 spawn_lots/0]).

-define(OUTDIR, "/eflame-export/").

-define(TRACE_OUTFILE, (?OUTDIR) ++ "out.trace").

spawn_lots() ->
    Pids = lists:map(
      fun (_) ->
			  erlang:spawn(poc_cowboy_oc_gen_server, start, [])
		  end, 
    lists:seq(1, 10000)),
    lists:foreach(fun(P) -> P ! gen_prime end , Pids   )
		 .

export_trace() ->
    eflame2:format_trace(?TRACE_OUTFILE,
			 (?OUTDIR) ++ file_timestamp() ++ ".flame") .

file_timestamp() ->
    {{Y, Mo, D}, {H, Mi, S}} =
	calendar:now_to_datetime(os:timestamp()),
    io_lib:format("~p-~p-~p-~p-~p-~p",
		  [Y, Mo, D, H, Mi, S]).

run_eflame_global_calls_plus_new_procs() ->
    io:format("Tracing started...\n"),
    run_eflame_global_calls_plus_new_procs(10 * 1000).

run_eflame_global_calls_plus_new_procs(Milliseconds) ->
    spawn(fun () ->
		  io:format("Tracing started... outfile: ~p \n",
			    [?TRACE_OUTFILE]),
		  eflame2:write_trace_exp(global_calls_plus_new_procs,
					  ?TRACE_OUTFILE, all, Milliseconds),
		  io:format("Tracing finished!\n")
	  end).


