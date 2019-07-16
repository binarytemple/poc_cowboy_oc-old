FROM bryanhuntesl/alpine-erlang-fritchie:20.0.5

RUN apk update && apk add curl make g++ git

RUN curl https://s3.amazonaws.com/rebar3/rebar3 -o /usr/local/bin/rebar3 && chmod 755 /usr/local/bin/rebar3

WORKDIR /opt/app

COPY . ./

RUN printf '[url "https://github.com/"] \ninsteadOf = git://github.com/\n[url "https://github.com/"]\ninsteadOf = git@github.com:\n' > /opt/app/.gitconfig

RUN rebar3 as prod release 

FROM bitwalker/alpine-erlang:20.0.5

COPY --from=0 /opt/app/_build/prod/rel/poc_cowboy_oc /opt/app/

WORKDIR /opt/app/

RUN apk update && apk add bind-tools

EXPOSE 4000

ENV REPLACE_OS_VARS=true

ENTRYPOINT ["/opt/app/bin/poc_cowboy_oc"]

CMD ["foreground"]
