use risc0_zkvm::guest::env;
use risc0_zkvm::sha::rust_crypto::{Digest as _, Sha256};
use std::io::Read;

fn main() {
    let mut data = [0u8; 32];
    env::stdin().read(&mut data).unwrap();

    let mut hasher = Sha256::default();
    hasher.update(&data);
    hasher.finalize_reset().to_vec();
}
