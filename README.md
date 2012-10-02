keccak-erlang
=============

An Erlang NIF for Keccak (SHA-3)

Usage
-----

    keccak:hash512(Message) -> binary()
        Types:
            Message = binary()
        Returns a 64 byte binary, given an arbitrary long message.
