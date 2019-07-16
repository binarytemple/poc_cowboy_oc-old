-module(poc_cowboy_oc).

-export([export_trace/0,
	 run_eflame_global_calls_plus_new_procs/0,
	 run_eflame_global_calls_plus_new_procs/1,
	 spawn_lots/0]).

-define(OUTDIR, "/eflame-export/").

-define(OUTFILE, (?OUTDIR) ++ "out.trace").

spawn_lots() ->
    lists:foreach(fun (_) ->
			  erlang:spawn(poc_cowboy_oc_gen_server, start, [])
		  end,
		  lists:seq(1, 10)).

export_trace() ->
    eflame2:format_trace(?OUTFILE,
			 (?OUTDIR) ++ file_timestamp()).

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
			    [?OUTFILE]),
		  eflame2:write_trace_exp(global_calls_plus_new_procs,
					  ?OUTFILE, all, Milliseconds),
		  io:format("Tracing finished!\n")
	  end).
