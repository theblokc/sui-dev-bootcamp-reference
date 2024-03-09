#[allow(unused_use)]
module test_coins::token {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct TOKEN has drop {}
    
    fun init(witness: TOKEN, ctx: &mut TxContext) {
        //id, decimal, name, symbol, description, icon
        let (treasury, metadata) = coin::create_currency(witness, 6, b"TOKEN", b"TKN", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<TOKEN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient);
    }
}