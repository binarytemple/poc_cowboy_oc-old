build:
	docker build  . -f ops/Dockerfile -t bryanhuntesl/poc_cowboy_oc:latest

run: build
	docker run -ti -p 4000:4000 -v eflame_export:/eflame-export --rm bryanhuntesl/poc_cowboy_oc console

push: build
	docker push bryanhuntesl/poc_cowboy_oc:latest

export: 
	docker run --rm -d --name=eflame-exporter -v eflame_export:/eflame-export alpine:latest /usr/bin/tail -f /dev/null
	docker cp exporter:/eflame-export .
	docker kill eflame-exporter
