// Based on example https://examples.sui.io/samples/coin.html

module zaggro_coin::zaggro_coin {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct ZAGGRO_COIN has drop {}

    fun init(witness: ZAGGRO_COIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"ZAGGRO_COIN", b"", b"", option::none(), ctx);
        transfer::freeze_object(metadata);
        transfer::transfer(treasury, tx_context::sender(ctx))
    }
}
