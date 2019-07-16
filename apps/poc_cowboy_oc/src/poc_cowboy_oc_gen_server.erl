-module(poc_cowboy_oc_gen_server).

-behaviour(gen_server).

-export([code_change/3, handle_call/3, handle_cast/2,
	 handle_info/2, init/1, terminate/2]).

-export([gen_primes/1, start/0]).

%% arbitrarily test the run function
-export([run/1]).

start() -> gen_server:start_link(?MODULE, [], []).

gen_primes(Pid) when is_pid(Pid) ->
    gen_server:cast(Pid, gen_primes).

init(_Args) -> {ok, []}.

handle_call(_, _From, State) -> {reply, State, State}.

handle_cast(gen_primes, State) ->
    run(1000000000000000000000000000000000000000000000000000),
    {noreply, State};
handle_cast(_Request, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

% generate primes - lets burn some cpu

sieve1([H | T], S) when H =< S ->
    [H | sieve1([X || X <- T, X rem H /= 0], S)];
sieve1(L, _) -> L.

filter(_, [], A) -> lists:reverse(A);
filter(P, [H | T], A) when H rem P == 0 ->
    filter(P, T, A);
filter(P, [H | T], A) -> filter(P, T, [H | A]).

sieve2([H | T], S) when H =< S ->
    [H | sieve2(filter(H, T, []), S)];
sieve2(L, _) -> L.

run(N) ->
    % erlang:display({start, now()}),
    _P1 = sieve1(lists:seq(3, N), math:sqrt(N)),
    % erlang:display({p1, now()}),
    _P2 = sieve2(lists:seq(3, N), math:sqrt(N)),
    % erlang:display({p2, now()})
    true.
