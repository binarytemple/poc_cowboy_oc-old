# `poc_cowboy_oc`


```
1> m('Elixir.ExBench.Application').
Module: 'Elixir.ExBench.Application'
MD5: dba342e57dec259c48780aecdc8c37e4
Compiled: No compile time info available
Object file: /code/bryanhuntesl/poc_cowboy_oc/_build/default/lib/ex_bench/ebin/Elixir.ExBench.Application.beam
Compiler options:  [dialyzer,no_spawn_compiler_process,from_core,
                    no_auto_import]
Exports:
         '__info__'/1
         default_filename/0
         module_info/0
         module_info/1
         run/0
         run/1
         start/2
         stop/0
         stop/1
ok
```

```
12> 'Elixir.Mix.ProjectStack':start_link([]).
```
or

```
application:ensure_all_started(ex_bench).
```

```
application:ensure_all_started(ex_bench).
```

```
'Elixir.ExBench.Application':run().
```
```
16> 'Elixir.ExBench.Application':run().
{ok,<0.785.0>}
17> {:test1, {'1', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'2', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'3', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'4', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'5', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'6', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'7', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'8', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}
{:test1, {'9', <<7, 166>>, %{}, [], false, %{"x" => "y"}}}

```

Or just add the `ex_bench`, `prometheus_ex`, and `mix` applications to '<your application>.app.src as shown:

```
    {application, poc_cowboy_oc,
     [{description, "POC Cowboy and opencensus"},
      {vsn, "0.1.0"},
      {registered, []},
      {mod, { poc_cowboy_oc_app, []}},
      {applications,
       [kernel,
        stdlib,
        cowboy,
        opencensus,
        mix,
        prometheus_ex,
        ex_bench
       ]},
```




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
