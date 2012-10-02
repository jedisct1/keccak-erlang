-module(keccak).
-export([hash512/1]).
-define(NOT_LOADED, not_loaded(?LINE)).
-on_load(init/0).

init() ->
    PrivDir = case code:priv_dir(?MODULE) of
        {error, _} ->
            EbinDir = filename:dirname(code:which(?MODULE)),
            AppPath = filename:dirname(EbinDir),
            filename:join(AppPath, "priv");
        Path ->
            Path
    end,
    erlang:load_nif(filename:join(PrivDir, "keccak"), 0).    

-spec hash512(Message :: binary()) -> binary().
hash512(Message) ->
    nif_hash512(Message).

not_loaded(Line) ->
    erlang:nif_error({not_loaded, [{module, ?MODULE}, {line, Line}]}).
   
nif_hash512(_Message) ->
    ?NOT_LOADED.
