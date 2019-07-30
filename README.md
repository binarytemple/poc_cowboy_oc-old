# `poc_cowboy_oc`

A throwaway project for experimenting with [eflame](https://github.com/bryanhuntesl/poc_cowboy_oc) and [ex_bench](https://github.com/bryanhuntesl/ex_bench).

It also demonstrates how to include an elixir dependency (:ex_bench) in an Erlang project (hint `rebar3_elixir` plugin). 

```bash
make run
```

```erlang
poc_cowboy_oc:global_and_local_calls_plus_new_procs().
```

Wait until it says it's tracing - then execute

```erlang
poc_cowboy_oc:spawn_lots().
```

Wait 10 seconds..

Press enter - you'll see the message - `Tracing finished!` - great we can export and view the trace.

```erlang
poc_cowboy_oc:export_trace().
```

Another terminal..

```bash
make flame
```

Open the flamegraph. Firefox renders it quite nicely.

```bash
open flamegraph.svg
```

----

Old stuff... ignore for now.

```bash
docker run --name=zipkin --network=ci -rm  -p 9411:9411 openzipkin/zipkin
```

```bash
docker run --name=oc --network=ci -rm  -p 9411:9411 bryanhuntesl/poc_cowboy_oc:latest foreground
```
