# `poc_cowboy_oc`

```bash
make run`
```

```erlang
poc_cowboy_oc:run_eflame_global_calls_plus_new_procs(),  poc_cowboy_oc:spawn_lots().  
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
