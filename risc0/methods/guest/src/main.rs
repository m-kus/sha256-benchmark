use risc0_zkvm::guest::env;
use risc0_zkvm::sha::rust_crypto::{Digest as _, Sha256};
use std::io::Read;

fn main() {
    let mut data = Vec::<u8>::new();
    env::stdin().read_to_end(&mut data).unwrap();

    let mut hasher = Sha256::default();
    hasher.update(&data);
    let res = hasher.finalize().to_vec();

    env::commit(&res);
}
