build:
	docker build  . -f ops/Dockerfile -t bryanhuntesl/poc_cowboy_oc:latest

run: build
	docker run --rm -ti -p 4000:4000 -v eflame_export:/eflame-export --rm bryanhuntesl/poc_cowboy_oc console

push: build
	docker push bryanhuntesl/poc_cowboy_oc:latest

_run_exporter:
	docker run --rm -d --name=eflame-exporter -v eflame_export:/eflame-export alpine:latest /usr/bin/tail -f /dev/null > /dev/null || true

_copy_out_files:
	docker cp eflame-exporter:/eflame-export .

_kill_exporter:
	docker kill eflame-exporter

export: _run_exporter _copy_out_files _kill_exporter

flame: export
	ls -t1 ./eflame-export/*.flame |  head -n 1 | xargs sed -e '/SLEEP/{d;}' | _build/default/lib/eflame/flamegraph.pl - > flamegraph.svg
	#ls -t1 ./eflame-export/*.flame |  head -n 1 | xargs sed -e '/SLEEP/{d;}' -e 's/^[^;]*;//'  | _build/default/lib/eflame/flamegraph.pl - > flamegraph.svg

open: flame
	open ./flamegraph.svg
