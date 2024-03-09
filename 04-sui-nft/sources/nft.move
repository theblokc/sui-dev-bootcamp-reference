module test_nft::nft {
    use std::string;
    use sui::url::{Self, Url};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct NFT has key, store {
        id: UID,
        name: string::String, 
        description: string::String,
        url: Url,
    }

    public entry fun mint(name: vector<u8>, description: vector<u8>, url: vector<u8>, ctx: &mut TxContext) {
        let nft = NFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
        };
        transfer::public_transfer(nft, tx_context::sender(ctx));
    }

    public entry fun transfer(nft: NFT, recipient: address) {
        transfer::public_transfer(nft, recipient);
    }
}