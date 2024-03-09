module test_project::contract {
    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct Contract has key, store {
        id: UID,
        text: string::String
    }

    public entry fun mint(ctx: &mut TxContext) {
        let token_obj = Contract {
            id: object::new(ctx),
            text: string::utf8(b"This is a Token")
        };
        transfer::public_transfer(token_obj, tx_context::sender(ctx));
    }

    #[test]
    public fun test_contract() {
        let ctx = tx_context::dummy();
        let token_obj = Contract {
            id: object::new(&mut ctx),
            text: string::utf8(b"This is a Test")
        };
        transfer::public_transfer(token_obj, tx_context::sender(&ctx));
    }
}