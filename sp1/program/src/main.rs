#![no_main]
sp1_zkvm::entrypoint!(main);

use sha2::{Sha256, Digest};

pub fn main() {
    let data = sp1_zkvm::io::read_vec();
    let mut hasher = Sha256::new();
    hasher.update(&data);
    let result = hasher.finalize();
    sp1_zkvm::io::commit_slice(&result);
}
