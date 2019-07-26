FROM bryanhuntesl/alpine-erlang:20.3.8.22-fritchies.eflame

RUN apk update && apk add curl make g++ git

RUN curl https://s3.amazonaws.com/rebar3/rebar3 -o /usr/local/bin/rebar3 && chmod 755 /usr/local/bin/rebar3

WORKDIR /opt/app

RUN printf '[url "https://github.com/"] \ninsteadOf = git://github.com/\n[url "https://github.com/"]\ninsteadOf = git@github.com:\n' > /opt/app/.gitconfig

COPY ./rebar.config ./rebar.config

COPY ./rebar.lock ./rebar.lock

# needed for elxir dependency - by default 1.8..
RUN apk add elixir  && mix local.hex --force && mix local.rebar --force

RUN rebar3 get-deps && rebar3 compile -d

COPY ./apps ./apps

COPY ./config ./config

RUN rebar3 as prod release

EXPOSE 4000

ENV REPLACE_OS_VARS=true

ENTRYPOINT ["/opt/app/_build/prod/rel/poc_cowboy_oc/bin/poc_cowboy_oc"]

CMD ["foreground"]
