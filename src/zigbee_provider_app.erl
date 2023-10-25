%%%-------------------------------------------------------------------
%% @doc etcd_provider public API
%% @end
%%%-------------------------------------------------------------------

-module(zigbee_provider_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    zigbee_provider_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
