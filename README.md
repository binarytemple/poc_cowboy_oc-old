# `poc_cowboy_oc`

```
docker run --name=zipkin --network=ci -rm  -p 9411:9411 openzipkin/zipkin
```


```
docker run --name=oc --network=ci -rm  -p 9411:9411 bryanhuntesl/poc_cowboy_oc:latest foreground
```
