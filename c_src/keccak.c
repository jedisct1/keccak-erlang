
#include "keccak.h"
#include "KeccakNISTInterface.h"

ERL_NIF_TERM
hash512(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    ErlNifBinary message;
    ErlNifBinary hash;

    if (argc != 1) {
        return enif_make_badarg(env);
    }
    if (enif_inspect_binary(env, argv[0], &message) == 0 ||
        message.size == 0U) {
        return enif_make_badarg(env);
    }
    enif_alloc_binary(64, &hash);
    Hash(512, (const BitSequence *) message.data,
         (DataLength) message.size * 8ULL, (BitSequence *) hash.data);

    return enif_make_binary(env, &hash);
}

static ErlNifFunc nif_funcs[] = {
    { "hash512", 1, hash512 }
};

ERL_NIF_INIT(keccak, nif_funcs, NULL, NULL, NULL, NULL)
