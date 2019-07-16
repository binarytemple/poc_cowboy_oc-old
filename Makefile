build:
	docker build  . -f ops/Dockerfile -t bryanhuntesl/poc_cowboy_oc:latest

docker-run: build
	docker run -ti -p 4000:4000 --rm bryanhuntesl/poc_cowboy_oc console

push: build
	docker push bryanhuntesl/poc_cowboy_oc:latest

